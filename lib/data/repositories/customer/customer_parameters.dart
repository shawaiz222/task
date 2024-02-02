class CreateCustomerParameters {
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? extention;

  CreateCustomerParameters({
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.extention,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'extention': extention
    };
  }
}

class UpdateCustomerParameters {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? extention;

  UpdateCustomerParameters(
      {this.name, this.email, this.phone, this.address, this.extention});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'extention': extention
    };
  }
}

class DeleteCustomerParameters {
  final List<String> ids;

  DeleteCustomerParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetCustomersQueryParameters {
  final String? search;
  final int? page;
  final int? limit;

  GetCustomersQueryParameters({
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
