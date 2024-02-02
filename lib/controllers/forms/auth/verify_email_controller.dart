import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/data/models/auth_models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/repositories/auth/auth_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';

class VerifyEmailFormController extends GetxController {
  final box = GetStorage();
  AuthRepository authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final _isLoading = false.obs;
  final _sendOtpLoading = false.obs;
  final nextPath = '/home'.obs;

  bool get isLoading => _isLoading.value;
  bool get sendOtpLoading => _sendOtpLoading.value;

  void setEmail(String value) => emailController.text = value;
  void setOtp(String value) => otpController.text = value;

  void reset() {
    emailController.text = '';
    otpController.text = '';
    _isLoading.value = false;
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

  void sendOtp() {
    _sendOtpLoading.value = true;
    authRepository
        .sendVerificationEmail(
      SendVerificationEmailParameters(
        email: emailController.text,
      ),
    )
        .then(
      (value) {
        _sendOtpLoading.value = false;
        if (value.error) {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );
        } else {
          Snackbar.show(
            message: 'OTP sent successfully',
            type: SnackType.success,
          );
        }
      },
    );
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      authRepository
          .verifyEmail(
        VerifyEmailParameters(
          email: emailController.text,
          otp: otpController.text,
        ),
      )
          .then((value) {
        _isLoading.value = false;
        if (value.error) {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );
        } else {
          Snackbar.show(
            message: 'Email verified successfully',
            type: SnackType.success,
          );

          var data = UserModel.fromMap(value.data);

          box.write('token', data.token);
          box.write('user', data);

          Get.offAllNamed(nextPath.value);
        }
      });
    }
  }
}
