import '../repositories/auth_repository.dart';

/// Use case for verifying OTP
class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  /// Execute the use case
  Future<bool> call(String mobileNumber, String otp) async {
    return await repository.verifyOtp(mobileNumber, otp);
  }
}

