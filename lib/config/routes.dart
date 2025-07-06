import 'package:expense_controll_app/app/home/home_view.dart';
import 'package:expense_controll_app/app/login/login_view.dart';
import 'package:expense_controll_app/app/register/register_view.dart';
import 'package:expense_controll_app/app/splash/splash_view.dart';
import 'package:flutter/material.dart';

// Nome das rotas
class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case splash:
        page = const SplashView();
        break;
      case login:
        page = const LoginView();
        break;
      case register:
        page = const RegisterView();
        break;
      case home:
        page = const HomeView();
        break;
      default:
        page = const Scaffold(body: Center(child: Text("Rota não encontrada")));
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
