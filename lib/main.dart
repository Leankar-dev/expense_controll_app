import 'package:expense_controll_app/core/app/expense_controll_app.dart';
import 'package:expense_controll_app/presentation/viewmodels/expense_view_model.dart';
import 'package:expense_controll_app/presentation/viewmodels/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_PT', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => ExpenseViewModel()),
      ],
      child: const ExpenseControllApp(),
    ),
  );
}
