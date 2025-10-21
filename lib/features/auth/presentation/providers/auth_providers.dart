import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/login_with_mobile.dart';
import '../../domain/usecases/verify_otp.dart';
import '../viewmodels/auth_state.dart';
import '../viewmodels/auth_viewmodel.dart';

/// Provider for LoginWithMobile use case
final loginWithMobileProvider = Provider<LoginWithMobile>((ref) => sl());

/// Provider for VerifyOtp use case
final verifyOtpProvider = Provider<VerifyOtp>((ref) => sl());

/// Provider for AuthViewModel
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    loginWithMobile: ref.read(loginWithMobileProvider),
    verifyOtp: ref.read(verifyOtpProvider),
  ),
);

