import 'package:expense_controll_app/config/theme.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/widgets/neumorphic_text_field.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../../config/routes.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  Future<void> _launchLeankarDev() async {
    final url = Uri.parse('https://www.leankar.dev');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Chamada ao ViewModel via GetIt
      showCustomSnackbar(context, 'Login realizado com sucesso');
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Expense Control App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 72),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 10,
                    intensity: 0.9,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(16),
                    ),
                    color: AppTheme.secondaryColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        NeumorphicTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value != null && value.contains('@')
                              ? null
                              : 'Email inválido',
                        ),
                        const SizedBox(height: 16),
                        NeumorphicTextField(
                          controller: _passwordController,
                          hintText: 'Senha',
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (value) =>
                              value != null && value.length >= 6
                              ? null
                              : 'Senha muito curta',
                        ),
                        const SizedBox(height: 24),
                        NeumorphicButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          style: NeumorphicStyle(
                            color: AppTheme.primaryColor,
                            shape: NeumorphicShape.flat,
                          ),
                          onPressed: _login,
                          child: const Center(
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: const Text("Não tem conta? Registre-se"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                GestureDetector(
                  onTap: _launchLeankarDev,
                  child: Text(
                    'Leankar.dev',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppTheme.secondaryColor
                          : AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
