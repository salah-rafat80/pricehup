import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/auth_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseModel>> requestOtp(String phoneNumber);
  Future<Either<Failure, AuthResponseModel>> verifyOtp(
    String phoneNumber,
    String otp,
  );
}
