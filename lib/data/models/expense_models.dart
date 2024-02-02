import 'dart:convert';

class ExpenseTypeModel {
  final String id;
  final String name;
  final String? description;

  ExpenseTypeModel({
    required this.id,
    required this.name,
    this.description,
  });

  factory ExpenseTypeModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTypeModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  String toJson() => json.encode(toMap());
}

class ExpenseModel {
  final String id;
  final ExpenseTypeModel type;
  final String? description;
  final double amount;
  final DateTime date;

  ExpenseModel({
    required this.id,
    required this.type,
    this.description,
    required this.amount,
    required this.date,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      type: ExpenseTypeModel.fromMap(map['type']),
      description: map['description'],
      amount: double.parse(map['amount'].toString()),
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toMap(),
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
