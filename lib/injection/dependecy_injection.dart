import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // // // Core Services
  // getIt.registerLazySingleton<AuthService>(() => AuthService());
  // getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  // getIt.registerLazySingleton<LocalDbService>(() => LocalDbService());
  // getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  // getIt.registerLazySingleton<PurchaseService>(() => PurchaseService());

  // // ViewModels
  // getIt.registerFactory<LoginViewModel>(() => LoginViewModel());
  // getIt.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  // getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  // getIt.registerFactory<TransactionViewModel>(() => TransactionViewModel());
  // getIt.registerFactory<CategoryViewModel>(() => CategoryViewModel());
  // getIt.registerFactory<DashboardViewModel>(() => DashboardViewModel());
  // getIt.registerFactory<SettingsViewModel>(() => SettingsViewModel());
}
