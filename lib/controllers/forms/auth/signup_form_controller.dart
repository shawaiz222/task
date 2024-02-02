import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/repositories/auth/auth_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/views/auth/verify_email_screen.dart';

class SignupFormController extends GetxController {
  AuthRepository authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setName(String value) => nameController.text = value;
  void setEmail(String value) => emailController.text = value;
  void setPassword(String value) => passwordController.text = value;
  void setConfirmPassword(String value) =>
      confirmPasswordController.text = value;

  void reset() {
    nameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    formKey = GlobalKey<FormState>();
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      authRepository
          .register(RegisterParameters(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ))
          .then((value) {
        _isLoading.value = false;
        if (value.error) {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );
        } else {
          Snackbar.show(
            message: 'Registration successful',
            type: SnackType.success,
          );

          Get.to(
            () => VerifyEmailScreen(
              email: emailController.text,
              nextPath: '/business-detail',
            ),
          );
        }
      });
    }
  }
}
