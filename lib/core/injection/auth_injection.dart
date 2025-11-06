// import 'package:get_it/get_it.dart';
// import 'package:my_gallery/core/network/app_http_manager.dart';
// import 'package:my_gallery/core/network/network_info.dart';
// import 'package:my_gallery/core/storage/storage_provider.dart';
// import 'package:my_gallery/features/auth/data/datasources/auth_local_datasource.dart';
// import 'package:my_gallery/features/auth/data/datasources/auth_remote_datasource.dart';
// import 'package:my_gallery/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:my_gallery/features/auth/domain/repositories/auth_repository.dart';
// import 'package:my_gallery/features/auth/domain/usecases/forget_password_user.dart';
// import 'package:my_gallery/features/auth/domain/usecases/login_google.dart';
// import 'package:my_gallery/features/auth/domain/usecases/login_user.dart';
// import 'package:my_gallery/features/auth/domain/usecases/register_google.dart';
// import 'package:my_gallery/features/auth/domain/usecases/registers_user.dart';
// import 'package:my_gallery/features/auth/presentation/bloc/auth_bloc.dart';

// final sl = GetIt.instance;

// Future<void> authInjection() async {
//   //! ---------------- Data Sources ----------------
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(
//       httpManager: sl<AppHttpManager>(),
//       storage: sl<StorageProvider>(),
//     ),
//   );

//   sl.registerLazySingleton<AuthLocalDataSource>(
//     () => AuthLocalDataSourceImpl(storage: sl<StorageProvider>()),
//   );

//   //! ---------------- Repository ----------------
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(
//       sl<AuthRemoteDataSource>(),
//       sl<AuthLocalDataSource>(),
//       sl<NetworkInfo>(),
//     ),
//   );

//   //! ---------------- Use Cases ----------------
//   sl.registerLazySingleton(() => AuthLoginUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(() => AuthRegisterUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(() => AuthForgetPwdUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(() => AuthLoginGoogleUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(
//     () => AuthRegisterGoogleUseCase(sl<AuthRepository>()),
//   );

//   //! ---------------- Bloc ----------------
//   sl.registerFactory(
//     () => AuthBloc(
//       login: sl<AuthLoginUseCase>(),
//       register: sl<AuthRegisterUseCase>(),
//       forget: sl<AuthForgetPwdUseCase>(),
//       google: sl<AuthLoginGoogleUseCase>(),
//       registerGoogle: sl<AuthRegisterGoogleUseCase>(),
//     ),
//   );
// }
