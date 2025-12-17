import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/auth_response_model.dart';
import '../repositories/auth_repository.dart';

/// Use case for initiating login with mobile number
class LoginWithMobile {
  final AuthRepository repository;

  LoginWithMobile(this.repository);

  /// Execute the use case
  Future<Either<Failure, AuthResponseModel>> call(String mobileNumber) async {
    return await repository.requestOtp(mobileNumber);
  }
}
