import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> loginWithMobile(String mobileNumber) async {
    return await remoteDataSource.sendOtp(mobileNumber);
  }

  @override
  Future<bool> verifyOtp(String mobileNumber, String otp) async {
    return await remoteDataSource.verifyOtp(mobileNumber, otp);
  }
}

