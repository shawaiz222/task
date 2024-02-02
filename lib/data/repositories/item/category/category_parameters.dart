class CreateCategoryParameters {
  final String name;
  final String? description;

  CreateCategoryParameters({
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

class UpdateCategoryParameters {
  final String? name;
  final String? description;

  UpdateCategoryParameters({
    this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class DeleteCategoryParameters {
  final List<String> ids;

  DeleteCategoryParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetCategoriesQueryParameters {
  final String? name;
  final int? page;
  final int? limit;

  GetCategoriesQueryParameters({
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
