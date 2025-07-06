import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/transaction_model.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../../app/transactions/transaction_view_model.dart';

class AddEditTransactionView extends ConsumerStatefulWidget {
  final TransactionModel? transaction;

  const AddEditTransactionView({super.key, this.transaction});

  @override
  ConsumerState<AddEditTransactionView> createState() =>
      _AddEditTransactionViewState();
}

class _AddEditTransactionViewState
    extends ConsumerState<AddEditTransactionView> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Outros';
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  ReceiptMethod _receiptMethod = ReceiptMethod.cash;
  TransactionType _transactionType = TransactionType.expense;

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      final t = widget.transaction!;
      _valueController.text = t.value.toString();
      _descController.text = t.description;
      _selectedCategory = t.category;
      _selectedDate = t.date;
      _paymentMethod = t.paymentMethod;
      _receiptMethod = t.receiptMethod;
      _transactionType = t.type;
    }
  }

  void _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (result != null) {
      setState(() {
        _selectedDate = result;
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final value = double.tryParse(_valueController.text) ?? 0;

    final transaction = TransactionModel(
      id: widget.transaction?.id,
      value: value,
      description: _descController.text,
      category: _selectedCategory,
      date: _selectedDate,
      paymentMethod: _paymentMethod,
      receiptMethod: _receiptMethod,
      type: _transactionType,
    );

    final viewModel = ref.read(transactionViewModelProvider.notifier);

    if (transaction.id == null) {
      viewModel.addTransaction(transaction);
      showCustomSnackbar(context, 'Transação adicionada com sucesso');
    } else {
      viewModel.updateTransaction(transaction);
      showCustomSnackbar(context, 'Transação atualizada com sucesso');
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Transação' : 'Nova Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Valor (€)'),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null || parsed < 0)
                    return 'Informe um valor válido ≥ 0';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Despesa'),
                    selected: _transactionType == TransactionType.expense,
                    selectedColor: Colors.red.shade300,
                    onSelected: (_) {
                      setState(
                        () => _transactionType = TransactionType.expense,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text('Receita'),
                    selected: _transactionType == TransactionType.income,
                    selectedColor: const Color(0xFF081F5C),
                    onSelected: (_) {
                      setState(() => _transactionType = TransactionType.income);
                    },
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items: const [
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
                  if (value != null) setState(() => _selectedCategory = value);
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Data'),
                subtitle: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PaymentMethod>(
                value: _paymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Forma de Pagamento',
                ),
                items: PaymentMethod.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _paymentMethod = val);
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ReceiptMethod>(
                value: _receiptMethod,
                decoration: const InputDecoration(
                  labelText: 'Forma de Recebimento',
                ),
                items: ReceiptMethod.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _receiptMethod = val);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
