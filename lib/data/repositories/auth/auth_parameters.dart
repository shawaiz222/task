class RegisterParameters {
  final String name;
  final String email;
  final String password;

  RegisterParameters({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class LoginParameters {
  final String email;
  final String password;

  LoginParameters({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SendVerificationEmailParameters {
  final String email;

  SendVerificationEmailParameters({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}

class VerifyEmailParameters {
  final String email;
  final String otp;

  VerifyEmailParameters({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}

class ForgotPasswordParameters {
  final String email;

  ForgotPasswordParameters({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}

class ResetPasswordParameters {
  final String email;
  final String otp;
  final String password;

  ResetPasswordParameters({
    required this.email,
    required this.otp,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
      'password': password,
    };
  }
}

class AddCompanyParameters {
  final String type;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? city;
  final String? state;
  final String? zipCode;
  final String country;
  final bool isMultiBranch;

  AddCompanyParameters({
    required this.type,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    required this.country,
    required this.isMultiBranch,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'isMultiBranch': isMultiBranch,
    };
  }
}
