import 'dart:convert';

class RoleModel {
  final String id;
  final String name;
  final List<String> permissions;

  RoleModel({
    required this.id,
    required this.name,
    required this.permissions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
    };
  }

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map['id'],
      name: map['name'],
      permissions: map['permissions'] != null
          ? List<String>.from(map['permissions'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());
}

class MemberModel {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? role;

  MemberModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());
}
