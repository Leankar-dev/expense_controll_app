// import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme.dart';
import '../../core/widgets/neumorphic_text_field.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../../config/routes.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  Future<void> _launchLeankarDev() async {
    final url = Uri.parse('https://www.leankar.dev');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        showCustomSnackbar(context, 'As senhas não coincidem');
        return;
      }

      showCustomSnackbar(context, 'Registro realizado com sucesso');
      Navigator.pushReplacementNamed(context, AppRoutes.login);
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
                          'Registrar',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        NeumorphicTextField(
                          controller: _nomeController,
                          hintText: 'Nome',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value != null && value.length >= 6
                              ? null
                              : 'Digite seu nome',
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
                        const SizedBox(height: 16),
                        NeumorphicTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirmar Senha',
                          obscureText: _obscurePassword,
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
                          onPressed: _register,
                          child: const Center(
                            child: Text(
                              'Registrar',
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
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                          child: const Text("Já tem conta? Entrar"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
