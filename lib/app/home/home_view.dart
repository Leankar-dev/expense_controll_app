import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/transactions/add_edit_transaction_view.dart';
import '../../app/transactions/transaction_view_model.dart';
import '../../core/models/transaction_model.dart';
import '../../app/transactions/transaction_filters.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionViewModelProvider);
    final sortOrder = ref.watch(sortOrderProvider);
    final categoryFilter = ref.watch(selectedCategoryProvider);
    final monthFilter = ref.watch(selectedMonthProvider);
    final viewModel = ref.read(transactionViewModelProvider.notifier);
    final filteredTransactions = viewModel.getFiltered(
      category: categoryFilter,
      month: monthFilter,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Filtros',
            onPressed: () => _showFilterDialog(context, ref),
          ),
          IconButton(
            icon: Icon(
              sortOrder == SortOrder.asc
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
            ),
            tooltip: 'Ordenar por data',
            onPressed: () {
              final newOrder = sortOrder == SortOrder.asc
                  ? SortOrder.desc
                  : SortOrder.asc;
              ref.read(sortOrderProvider.notifier).state = newOrder;
              viewModel.sortByDate(newOrder);
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

                return Dismissible(
                  key: Key(t.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Confirmar Exclusão'),
                        content: const Text('Deseja excluir esta transação?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: const Text('Excluir'),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (_) {
                    ref
                        .read(transactionViewModelProvider.notifier)
                        .deleteTransaction(t.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transação deletada com sucesso'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  child: ListTile(
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

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final category = ref.read(selectedCategoryProvider);
    final date = ref.read(selectedMonthProvider);

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(labelText: 'Categoria'),
              items: const [
                DropdownMenuItem(value: null, child: Text('Todas')),
                DropdownMenuItem(
                  value: 'Alimentação',
                  child: Text('Alimentação'),
                ),
                DropdownMenuItem(
                  value: 'Transporte',
                  child: Text('Transporte'),
                ),
                DropdownMenuItem(value: 'Educação', child: Text('Educação')),
                DropdownMenuItem(value: 'Saúde', child: Text('Saúde')),
                DropdownMenuItem(value: 'Outros', child: Text('Outros')),
              ],
              onChanged: (value) {
                ref.read(selectedCategoryProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Período (mês/ano)'),
              subtitle: Text(
                date != null
                    ? '${date.month.toString().padLeft(2, '0')}/${date.year}'
                    : 'Todos',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: date ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  helpText: 'Selecione o mês',
                );
                if (selected != null) {
                  ref.read(selectedMonthProvider.notifier).state = selected;
                }
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ref.read(selectedCategoryProvider.notifier).state = null;
                ref.read(selectedMonthProvider.notifier).state = null;
                Navigator.pop(context);
              },
              child: const Text('Limpar filtros'),
            ),
          ],
        ),
      ),
    );
  }
}
