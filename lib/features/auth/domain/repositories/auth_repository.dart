/// Abstract repository for authentication operations
/// This defines the contract that the data layer must implement
abstract class AuthRepository {
  /// Send OTP to the provided mobile number
  Future<void> loginWithMobile(String mobileNumber);

  /// Verify the OTP code for the given mobile number
  Future<bool> verifyOtp(String mobileNumber, String otp);
}

