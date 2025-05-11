import 'package:expense_controll_app/core/routes/app_routes.dart';
import 'package:expense_controll_app/core/themes/app_theme.dart';
import 'package:expense_controll_app/presentation/viewmodels/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseControllApp extends StatelessWidget {
  const ExpenseControllApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeViewModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpenseControll_APP',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}












//   @override
//   Widget build(BuildContext context) {
    
//     return MaterialApp(
//       title: 'Expense Control App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: SplashView(),
//     );
//   }
// }
