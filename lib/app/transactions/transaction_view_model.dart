import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../core/models/transaction_model.dart';
import '../../core/services/local_db_service.dart';

final transactionViewModelProvider =
    StateNotifierProvider<TransactionViewModel, List<TransactionModel>>(
      (ref) => TransactionViewModel(),
    );

class TransactionViewModel extends StateNotifier<List<TransactionModel>> {
  final _db = GetIt.I<LocalDbService>();

  TransactionViewModel() : super([]) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final data = await _db.getAllTransactions();
    state = data;
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _db.insertTransaction(transaction);
    await loadTransactions();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    if (transaction.id == null) return;
    await _db.updateTransaction(transaction);
    await loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await _db.deleteTransaction(id);
    await loadTransactions();
  }

  double getTotalByDay(DateTime date) {
    return state
        .where(
          (e) =>
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        )
        .fold(0, (prev, e) => prev + e.value);
  }

  double getTotalByMonth(int year, int month) {
    return state
        .where((e) => e.date.year == year && e.date.month == month)
        .fold(0, (prev, e) => prev + e.value);
  }

  double getTotalBalance() {
    return state.fold(0, (prev, e) => prev + e.value);
  }

  List<TransactionModel> filterByCategory(String category) {
    return state.where((e) => e.category == category).toList();
  }

  List<TransactionModel> filterByPeriod(DateTime start, DateTime end) {
    return state
        .where((e) => e.date.isAfter(start) && e.date.isBefore(end))
        .toList();
  }
}
