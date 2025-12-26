import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pricehup/features/auth/domain/usecases/login_with_mobile.dart';
import 'package:pricehup/features/auth/domain/usecases/verify_otp.dart';
import 'package:pricehup/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithMobile loginWithMobile;
  final VerifyOtp verifyOtpUseCase;

  // Store phone number to use in verification
  String? _phoneNumber;

  final SharedPreferences sharedPreferences;

  AuthCubit({
    required this.loginWithMobile,
    required this.verifyOtpUseCase,
    required this.sharedPreferences,
  }) : super(AuthInitial());

  Future<void> login(String phoneNumber) async {
    if (phoneNumber.length < 9) {
      emit(const AuthError(message: 'رقم الجوال غير صحيح'));
      return;
    }

    _phoneNumber = phoneNumber;
    emit(AuthLoading());

    final result = await loginWithMobile(phoneNumber);

    result.fold((failure) => emit(AuthError(message: failure.message)), (
      response,
    ) {
      if (response.status == 'error') {
        emit(
          AuthError(
            message:
                response.messageAr ?? response.messageEn ?? 'Unknown error',
          ),
        );
      } else {
        emit(AuthOtpSent(response: response));
      }
    });
  }

  Future<void> verifyOtp(String otp) async {
    if (_phoneNumber == null) {
      emit(const AuthError(message: 'Phone number not found'));
      return;
    }

    emit(AuthLoading());

    final result = await verifyOtpUseCase(_phoneNumber!, otp);

    result.fold((failure) => emit(AuthError(message: failure.message)), (
      response,
    ) {
      if (response.status == 'error') {
        emit(
          AuthError(
            message:
                response.messageAr ?? response.messageEn ?? 'Unknown error',
          ),
        );
      } else {
        if (response.token != null) {
          sharedPreferences.setString('auth_token', response.token!);
        }
        emit(AuthVerified(response: response));
      }
    });
  }

  void reset() {
    emit(AuthInitial());
  }
}
