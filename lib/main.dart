import 'package:expense_controll_app/core/app/expense_controll_app.dart';
import 'package:expense_controll_app/presentation/viewmodels/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeViewModel())],
      child: const ExpenseControllApp(),
    ),
  );
}
