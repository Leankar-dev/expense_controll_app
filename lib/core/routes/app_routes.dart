import 'package:expense_controll_app/presentation/views/home_view/home_view.dart';
import 'package:expense_controll_app/presentation/views/splash_view/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashView(),
    home: (_) => const HomeView(),
  };
}
