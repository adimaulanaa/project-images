import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:my_gallery/core/network/app_http_manager.dart';
import 'package:my_gallery/core/network/network_info.dart';
import 'package:my_gallery/core/storage/storage_provider.dart';
import 'package:my_gallery/core/utils/date_format.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  await initDateFormat();

  // 1. Storage Provider harus didaftarkan PERTAMA
  final storageProvider = await StorageProvider.create();
  sl.registerSingleton<StorageProvider>(storageProvider);

  sl.registerLazySingleton<AppHttpManager>(
    () => AppHttpManager.instantiate(sl.call<StorageProvider>()), // 👈 Injeksi Storage
  ); 
  
  //! Auth
  // await authInjection();
}
