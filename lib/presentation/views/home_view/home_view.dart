import 'package:expense_controll_app/core/widgets/custom_appbar.dart';
import 'package:expense_controll_app/core/widgets/custom_navigation_bar.dart';
import 'package:expense_controll_app/core/widgets/expense_bar_chart_widget.dart';
import 'package:expense_controll_app/core/widgets/expense_pie_chart_widget.dart';
import 'package:expense_controll_app/core/widgets/summary_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: CustomAppbar(title: 'Expense Controll App'),
      bottomNavigationBar: CustomNavigationBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SummaryCard(title: 'Titulo', amount: 5000, subtitle: 'subtitle'),
            const SizedBox(height: 16),
            SummaryCard(title: 'Titulo', amount: 10000, subtitle: 'subtitle'),
            const SizedBox(height: 24),
            Text(
              'Despesas por Categoria',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const ExpenseBarChartWidget(),
            const SizedBox(height: 24),
            Text(
              'Despesas por Mês',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const ExpensePieChartWidget(),
          ],
        ),
      ),
    );
  }
}
