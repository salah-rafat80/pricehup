import 'package:get_it/get_it.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_mobile.dart';
import 'features/auth/domain/usecases/verify_otp.dart';
import 'features/home/data/datasources/category_local_data_source.dart';
import 'features/home/data/repositories/category_repository_impl.dart';
import 'features/home/domain/repositories/category_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';

final sl = GetIt.instance;

/// Initialize all dependencies for the app
Future<void> init() async {
  // ============== Features - Auth ==============

  // Use cases
  sl.registerLazySingleton(() => LoginWithMobile(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // ============== Features - Home ==============

  // Use cases
  sl.registerLazySingleton(() => GetCategories(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(),
  );
}

