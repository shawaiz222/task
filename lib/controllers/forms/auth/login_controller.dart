import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/repositories/auth/auth_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/views/auth/verify_email_screen.dart';
import 'package:invoder_app/data/models/auth_models.dart';

class LoginFormController extends GetxController {
  final box = GetStorage();
  AuthRepository authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setEmail(String value) => emailController.text = value;
  void setPassword(String value) => passwordController.text = value;

  void reset() {
    emailController.text = '';
    passwordController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
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

  void submit() {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      authRepository
          .login(
        LoginParameters(
          email: emailController.text,
          password: passwordController.text,
        ),
      )
          .then((value) {
        _isLoading.value = false;
        if (value.error) {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );

          if (value.statusCode == 403) {
            Get.to(
              () => VerifyEmailScreen(
                email: emailController.text,
              ),
            );
          }
        } else {
          Snackbar.show(
            message: 'Login successful',
            type: SnackType.success,
          );
          var data = value.data;

          box.write('token', data['token']);
          var userData = UserModel.fromMap(value.data);
          box.write('user', userData);

          if (data['user']['company'] == null) {
            Get.offAllNamed('/business-detail');
            return;
          }

          Get.offAllNamed('/home');
        }
      });
    }
  }
}
