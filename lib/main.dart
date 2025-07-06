import 'package:expense_controll_app/app/app.dart';
import 'package:expense_controll_app/injection/dependecy_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const ProviderScope(child: ExpenseControllApp()));
}
