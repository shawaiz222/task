class CreateAttributeParameters {
  final String name;
  final String displayName;
  final List<dynamic> values;

  CreateAttributeParameters({
    required this.name,
    required this.displayName,
    required this.values,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'displayName': displayName,
      'values': values.map((e) => e.toMap()).toList(),
    };
  }
}

class UpdateAttributeParameters {
  final String? name;
  final String? displayName;
  final List<dynamic>? values;

  UpdateAttributeParameters({
    this.name,
    this.displayName,
    this.values,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'displayName': displayName,
      'values': values?.map((e) => e.toMap()).toList(),
    };
  }
}

class DeleteAttributeParameters {
  final List<String> ids;

  DeleteAttributeParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetAttributesQueryParameters {
  final String? name;
  final int? page;
  final int? limit;
  final List<String>? ids;

  GetAttributesQueryParameters({
    this.name,
    this.page,
    this.limit,
    this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'page': page,
      'limit': limit,
      'ids': ids,
    };
  }
}
