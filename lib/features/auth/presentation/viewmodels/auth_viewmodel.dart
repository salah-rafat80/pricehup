import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_with_mobile.dart';
import '../../domain/usecases/verify_otp.dart';
import 'auth_state.dart';

/// ViewModel for authentication feature following MVVM pattern
class AuthViewModel extends StateNotifier<AuthState> {
  final LoginWithMobile loginWithMobile;
  final VerifyOtp verifyOtp;

  AuthViewModel({
    required this.loginWithMobile,
    required this.verifyOtp,
  }) : super(const AuthState());

  /// Update mobile number in state
  void setMobileNumber(String value) {
    state = state.copyWith(mobileNumber: value, error: null);
  }

  /// Send OTP to mobile number
  Future<void> sendOtp() async {
    if (state.mobileNumber.length < 9) {
      state = state.copyWith(error: 'رقم الجوال غير صحيح');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await loginWithMobile(state.mobileNumber);
      state = state.copyWith(isLoading: false, isOtpSent: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'حدث خطأ، يرجى المحاولة مرة أخرى',
      );
    }
  }

  /// Verify OTP code
  Future<bool> verifyOtpCode(String otp) async {
    if (otp.length != 6) {
      state = state.copyWith(error: 'الرجاء إدخال الكود كاملاً');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final isValid = await verifyOtp(state.mobileNumber, otp);

      if (isValid) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'الكود غير صحيح',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'حدث خطأ، يرجى المحاولة مرة أخرى',
      );
      return false;
    }
  }
}
