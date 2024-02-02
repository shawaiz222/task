class CreateRoleParameters {
  final String name;
  final List<String> permissions;

  CreateRoleParameters({
    required this.name,
    required this.permissions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'permissions': permissions,
    };
  }
}

class UpdateRoleParameters {
  final String? name;
  final List<String>? permissions;

  UpdateRoleParameters({
    this.name,
    this.permissions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'permissions': permissions,
    };
  }
}

class DeleteRoleParameters {
  final List<String> ids;

  DeleteRoleParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetRolesQueryParameters {
  final String? search;
  final int? page;
  final int? limit;

  GetRolesQueryParameters({
    this.search,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'search': search,
      'page': page,
      'limit': limit,
    };
  }
}
