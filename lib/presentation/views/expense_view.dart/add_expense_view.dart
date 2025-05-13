import 'package:expense_controll_app/data/models/expense_model.dart';
import 'package:expense_controll_app/presentation/viewmodels/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final _amountControllerEC = TextEditingController();
  final _descriptionControllerEC = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;
  String? _selectedPaymentMethod;

  final List<String> categories = [
    'Alimentação',
    'Transporte',
    'Saúde',
    'Educação',
    'Lazer',
    'Outros',
  ];

  final List<String> paymentMethods = [
    'Cartão de crédito',
    'Cartão de débito',
    'Dinheiro',
    'MBWay',
  ];

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_PT', symbol: '€');
    final expenseProvider = Provider.of<ExpenseViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Lançar as despesas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountControllerEC,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  prefixText: '€',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor informe o valor';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Valor inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items:
                    categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator:
                    (value) => value == null ? 'Escolha uma categoria' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionControllerEC,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Data da despesa'),
                subtitle: Text(
                  DateFormat(
                    'dd \'de\' MMMM \'de\' yyyy',
                    'pt_PT',
                  ).format(_selectedDate),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                leading: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    locale: const Locale('pt', 'PT'),
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() => _selectedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Forma de pagamento',
                ),
                items:
                    paymentMethods
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                onChanged:
                    (value) => setState(() => _selectedPaymentMethod = value),
                validator:
                    (value) =>
                        value == null ? 'Escolha a forma de pagamento' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final amount = double.parse(
                      _amountControllerEC.text.replaceAll(',', '.'),
                    );

                    final newExpense = ExpenseModel(
                      amount: amount,
                      category: _selectedCategory!,
                      description:
                          _descriptionControllerEC.text.trim().isEmpty
                              ? null
                              : _descriptionControllerEC.text.trim(),
                      date: _selectedDate,
                      paymentMethod: _selectedPaymentMethod!,
                    );

                    await expenseProvider.addExpense(newExpense);
                    Navigator.pop(context);
                  }
                },
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
