import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/auth_response_model.dart';
import '../repositories/auth_repository.dart';

/// Use case for verifying OTP
class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  /// Execute the use case
  Future<Either<Failure, AuthResponseModel>> call(
    String mobileNumber,
    String otp,
  ) async {
    return await repository.verifyOtp(mobileNumber, otp);
  }
}
