/// Abstract data source for auth remote operations
abstract class AuthRemoteDataSource {
  Future<void> sendOtp(String mobileNumber);
  Future<bool> verifyOtp(String mobileNumber, String otp);
}

/// Implementation of auth remote data source
/// In a real app, this would make actual API calls
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> sendOtp(String mobileNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In real app: make API call to send OTP
  }

  @override
  Future<bool> verifyOtp(String mobileNumber, String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In real app: make API call to verify OTP
    // For demo, accept any 6-digit code
    return otp.length == 6;
  }
}

