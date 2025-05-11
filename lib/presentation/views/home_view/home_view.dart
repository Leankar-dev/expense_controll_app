import 'package:expense_controll_app/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Expense Controll App2'),
      body: Container(
        color: Colors.amber[100],
        child: const Center(child: Text('Expense Controll App')),
      ),
    );
  }
}
