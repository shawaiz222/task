import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/repositories/auth/auth_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';

class ResetPasswordFormController extends GetxController {
  AuthRepository authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setEmail(String value) => emailController.text = value;
  void setOtp(String value) => otpController.text = value;
  void setPassword(String value) => passwordController.text = value;
  void setConfirmPassword(String value) =>
      confirmPasswordController.text = value;

  void reset() {
    emailController.text = '';
    otpController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    formKey = GlobalKey<FormState>();
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

  String? validateOtp(String? value) {
    if (value!.isEmpty) {
      return 'OTP is required';
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
      return 'Confirm Password is required';
    }
    if (value != passwordController.text) {
      return 'Confirm Password must match Password';
    }
    return null;
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      authRepository
          .resetPassword(
        ResetPasswordParameters(
          email: emailController.text,
          otp: otpController.text,
          password: passwordController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (value.error) {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          } else {
            Snackbar.show(
              message: 'Password reset successfully',
              type: SnackType.success,
            );
            Get.offAllNamed('/login');
          }
        },
      );
    }
  }
}
