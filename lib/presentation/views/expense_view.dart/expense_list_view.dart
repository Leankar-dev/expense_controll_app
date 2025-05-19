import 'package:expense_controll_app/presentation/viewmodels/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExpenseViewModel>(context);
    final expenses = viewModel.expenses;
    final currencyFormat = NumberFormat.currency(locale: 'pt_PT', symbol: '€');
    final dateFormat = DateFormat.yMMMd('pt_PT');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, viewModel),
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => viewModel.clearFilters(),
          ),
        ],
      ),
      body:
          expenses.isEmpty
              ? const Center(child: Text('Nenhuma despesa encontrada.'))
              : ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return ListTile(
                    title: Text(expense.category),
                    subtitle: Text(dateFormat.format(expense.date)),
                    trailing: Text(currencyFormat.format(expense.amount)),
                  );
                },
              ),
    );
  }

  void _showFilterDialog(BuildContext context, ExpenseViewModel viewModel) {
    final categories =
        viewModel.expenses.map((e) => e.category).toSet().toList();
    String? selectedCategory =
        viewModel.expenses.isNotEmpty
            ? viewModel.expenses.first.category
            : null;
    DateTime? selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtros'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items:
                    categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                onChanged: (value) => selectedCategory = value,
                decoration: const InputDecoration(labelText: 'Categoria'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    locale: const Locale('pt', 'PT'),
                  );
                  if (picked != null) {
                    selectedDate = picked;
                  }
                },
                child: const Text('Selecionar Mês'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.setCategoryFilter(selectedCategory);
                viewModel.setMonthFilter(selectedDate);
                Navigator.of(context).pop();
              },
              child: const Text('Aplicar'),
            ),
          ],
        );
      },
    );
  }
}
