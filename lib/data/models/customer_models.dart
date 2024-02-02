import 'dart:convert';

class CustomerModel {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;

  CustomerModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  String toJson() => json.encode(toMap());
}
