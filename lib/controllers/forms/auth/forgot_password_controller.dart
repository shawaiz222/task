import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/repositories/auth/auth_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/views/auth/reset_password_screen.dart';

class ForgotPasswordFormController extends GetxController {
  AuthRepository authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setEmail(String value) => emailController.text = value;

  void reset() {
    emailController.text = '';
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

  void submit() {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      authRepository
          .forgotPassword(
        ForgotPasswordParameters(
          email: emailController.text,
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
              message: 'OTP is sent to your email. Please check your inbox',
              type: SnackType.success,
            );
            Get.to(() => ResetPasswordScreen(email: emailController.text));
          }
        },
      );
    }
  }
}
