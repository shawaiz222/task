class CreateExpenseTypeParameters {
  final String name;
  final String? description;

  CreateExpenseTypeParameters({
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class CreateExpenseParameters {
  final String type;
  final String? description;
  final double amount;
  final DateTime date;

  CreateExpenseParameters({
    required this.type,
    this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}

class UpdateExpenseParameters {
  final String? type;
  final String? description;
  final double? amount;
  final DateTime? date;

  UpdateExpenseParameters({
    this.type,
    this.description,
    this.amount,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'description': description,
      'amount': amount,
      'date': date?.toIso8601String(),
    };
  }
}

class DeleteExpenseParameters {
  final List<String> ids;

  DeleteExpenseParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetExpensesQueryParameters {
  final String? type;
  final DateTime? date;
  final int? page;
  final int? limit;

  GetExpensesQueryParameters({
    this.type,
    this.date,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'date': date?.toIso8601String(),
      'page': page,
      'limit': limit,
    };
  }
}
