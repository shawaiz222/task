class CreateUnitParameters {
  final String name;
  final String shortName;
  final String? description;

  CreateUnitParameters({
    required this.name,
    required this.shortName,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortName': shortName,
      'description': description,
    };
  }
}

class UpdateUnitParameters {
  final String? name;
  final String? shortName;
  final String? description;

  UpdateUnitParameters({
    this.name,
    this.shortName,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortName': shortName,
      'description': description,
    };
  }
}

class DeleteUnitParameters {
  final List<String> ids;

  DeleteUnitParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetUnitsQueryParameters {
  final String? name;
  final int? page;
  final int? limit;

  GetUnitsQueryParameters({
    this.name,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'page': page,
      'limit': limit,
    };
  }
}
