import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(child: Text("gráfico de pizza")),
    );
  }
}

class ExpenseBarChart extends StatelessWidget {
  const ExpenseBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(child: Text("gráfico de barras")),
    );
  }
}
