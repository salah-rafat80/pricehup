import '../repositories/auth_repository.dart';

/// Use case for initiating login with mobile number
class LoginWithMobile {
  final AuthRepository repository;

  LoginWithMobile(this.repository);

  /// Execute the use case
  Future<void> call(String mobileNumber) async {
    return await repository.loginWithMobile(mobileNumber);
  }
}

