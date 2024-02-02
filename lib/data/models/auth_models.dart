import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final bool verified;
  final dynamic role;
  late final dynamic company;
  final String type;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.verified,
    this.role,
    this.company,
    required this.type,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user']['id'] ?? '',
      name: map['user']['name'] ?? '',
      email: map['user']['email'] ?? '',
      verified: map['user']['verified'] ?? false,
      role: map['user']['role'],
      company: map['user']['company'],
      type: map['user']['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'verified': verified,
      'role': role,
      'company': company,
      'type': type,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);
}
