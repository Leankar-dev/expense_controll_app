enum PaymentMethod { creditCard, mbWay, cash, debitCard, pix }

enum ReceiptMethod { cash, deposit, pix }

enum TransactionType { income, expense }

class TransactionModel {
  final int? id;
  final double value;
  final String category;
  final String description;
  final DateTime date;
  final PaymentMethod paymentMethod;
  final ReceiptMethod receiptMethod;
  final TransactionType type;

  TransactionModel({
    this.id,
    required this.value,
    required this.category,
    required this.description,
    required this.date,
    required this.paymentMethod,
    required this.receiptMethod,
    required this.type,
  }) : assert(value >= 0, 'O valor não pode ser negativo.');

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      value: map['value'],
      category: map['category'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == map['paymentMethod'],
      ),
      receiptMethod: ReceiptMethod.values.firstWhere(
        (e) => e.name == map['receiptMethod'],
      ),
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'value': value,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod.name,
      'receiptMethod': receiptMethod.name,
      'type': type.name,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();
}
