import 'package:expense_controll_app/app/app.dart';
// import 'package:expense_controll_app/core/services/local_db_service.dart';
import 'package:expense_controll_app/injection/dependecy_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  // await GetIt.I<LocalDbService>().resetAndRecreateDatabase();
  runApp(const ProviderScope(child: ExpenseControllApp()));
}
