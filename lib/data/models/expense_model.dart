import 'dart:convert';

class ExpenseModel {
  final int? id;
  final double amount;
  final String category;
  final String? description;
  final DateTime date;
  final String paymentMethod;

  ExpenseModel({
    this.id,
    required this.amount,
    required this.category,
    this.description,
    required this.date,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      paymentMethod: map['paymentMethod'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
