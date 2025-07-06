import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/transactions/add_edit_transaction_view.dart';
import '../../app/transactions/transaction_view_model.dart';
import '../../core/models/transaction_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: implementar filtros
            },
          ),
        ],
      ),
      body: transactions.isEmpty
          ? const Center(child: Text('Nenhuma transação encontrada.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final t = transactions[index];
                final isIncome = t.type == TransactionType.income;
                final valueColor = isIncome
                    ? const Color(0xFF081F5C)
                    : Colors.red;

                return ListTile(
                  title: Text(
                    '${t.category} - €${t.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                  subtitle: Text(
                    '${t.description}\n${_formatDate(t.date)} • ${t.paymentMethod.name} → ${t.receiptMethod.name}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddEditTransactionView(transaction: t),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTransactionView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
