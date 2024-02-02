class CreateMemberParameters {
  final String name;
  final String email;
  final String phone;
  final String role;

  CreateMemberParameters({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }

  factory CreateMemberParameters.fromMap(Map<String, dynamic> map) {
    return CreateMemberParameters(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
    );
  }
}

class UpdateMemberParameters {
  final String? name;
  final String? email;
  final String? phone;
  final String? role;

  UpdateMemberParameters({
    this.name,
    this.email,
    this.phone,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }
}

class DeleteMemberParameters {
  final List<String> ids;

  DeleteMemberParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetMembersQueryParameters {
  final String? search;
  final int? page;
  final int? limit;

  GetMembersQueryParameters({
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
