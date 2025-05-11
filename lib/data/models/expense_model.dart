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
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] != null ? map['id'] as int : null,
      amount: map['amount'] as double,
      category: map['category'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      paymentMethod: map['paymentMethod'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
