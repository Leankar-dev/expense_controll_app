import 'package:expense_controll_app/app/transactions/transaction_view_model.dart';
import 'package:expense_controll_app/core/services/auth_service.dart';
import 'package:expense_controll_app/core/services/firestore_service.dart';
import 'package:expense_controll_app/core/services/local_db_service.dart';
import 'package:expense_controll_app/core/services/notification_service.dart';
import 'package:expense_controll_app/core/services/purchase_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Core Services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<LocalDbService>(() => LocalDbService());
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<PurchaseService>(() => PurchaseService());

  // ViewModels
  // getIt.registerFactory<LoginViewModel>(() => LoginViewModel());
  // getIt.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  // getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  getIt.registerFactory<TransactionViewModel>(() => TransactionViewModel());
  // getIt.registerFactory<CategoryViewModel>(() => CategoryViewModel());
  // getIt.registerFactory<DashboardViewModel>(() => DashboardViewModel());
  // getIt.registerFactory<SettingsViewModel>(() => SettingsViewModel());
}
