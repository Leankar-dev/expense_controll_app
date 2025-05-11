import 'package:expense_controll_app/data/datasources/expense_dao.dart';
import 'package:expense_controll_app/data/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseDao _dao = ExpenseDao();

  List<ExpenseModel> _expenses = [];

  List<ExpenseModel> get expenses => _expenses;

  Future<void> fetchExpenses() async {
    _expenses = await _dao.getAllExpenses();
    notifyListeners();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await _dao.insertExpense(expense);
    await fetchExpenses();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await _dao.updateExpense(expense);
    await fetchExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await _dao.deleteExpense(id);
    await fetchExpenses();
  }
}
