import 'package:expense_controll_app/data/services/expense_dao.dart';
import 'package:expense_controll_app/data/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  List<ExpenseModel> _allExpenses = [];
  List<ExpenseModel> _filteredExpenses = [];

  List<ExpenseModel> get expenses => _filteredExpenses;

  String? _selectedCategory;
  DateTime? _selectedMonth;

  ExpenseViewModel() {
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    _allExpenses = await ExpenseDao.instance.getAllExpenses();
    applyFilters();
  }

  void applyFilters() {
    _filteredExpenses =
        _allExpenses.where((expense) {
          final matchesCategory =
              _selectedCategory == null ||
              expense.category == _selectedCategory;
          final matchesMonth =
              _selectedMonth == null ||
              (expense.date.year == _selectedMonth!.year &&
                  expense.date.month == _selectedMonth!.month);
          return matchesCategory && matchesMonth;
        }).toList();

    _filteredExpenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void setCategoryFilter(String? category) {
    _selectedCategory = category;
    applyFilters();
  }

  void setMonthFilter(DateTime? month) {
    _selectedMonth = month;
    applyFilters();
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedMonth = null;
    applyFilters();
  }
}

// class ExpenseViewModel extends ChangeNotifier {
//   final ExpenseDao _dao = ExpenseDao();

//   List<ExpenseModel> _expenses = [];

//   List<ExpenseModel> get expenses => _expenses;

//   Future<void> fetchExpenses() async {
//     _expenses = await _dao.getAllExpenses();
//     notifyListeners();
//   }

//   Future<void> addExpense(ExpenseModel expense) async {
//     await _dao.insertExpense(expense);
//     await fetchExpenses();
//   }

//   Future<void> updateExpense(ExpenseModel expense) async {
//     await _dao.updateExpense(expense);
//     await fetchExpenses();
//   }

//   Future<void> deleteExpense(int id) async {
//     await _dao.deleteExpense(id);
//     await fetchExpenses();
//   }
// }
