import 'package:expense_controll_app/core/widgets/custom_appbar.dart';
import 'package:expense_controll_app/core/widgets/custom_navigation_bar.dart';
import 'package:expense_controll_app/core/widgets/expense_chart.dart';
import 'package:expense_controll_app/core/widgets/summary_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Expense Controll App'),
      body: Container(
        color: Colors.amber[100],
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                SummaryCard(
                  title: 'TITULO1',
                  amount: 5000,
                  subtitle: 'subtitulo1',
                ),
                SizedBox(height: 15),
                SummaryCard(
                  title: 'TITULO2',
                  amount: 10000,
                  subtitle: 'subtitulo2',
                ),
                SizedBox(height: 15),
                ExpenseBarChart(),
                SizedBox(height: 15),
                ExpensePieChart(),
                SizedBox(height: 15),
                CustomNavigationBar(currentIndex: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
