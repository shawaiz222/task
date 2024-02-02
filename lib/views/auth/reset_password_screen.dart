import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:invoder_app/utils/colors.dart';
import '../../components/ui/index.dart';
import '../../controllers/forms/auth/reset_password_controller.dart';
import '../../utils//custom_icons.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordFormController controller =
      Get.put(ResetPasswordFormController());

  @override
  void initState() {
    controller.setEmail(widget.email);
    super.initState();
  }

  @override
  void dispose() {
    controller.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor.shade900,
          statusBarIconBrightness: Brightness.light,
        ),
        leading: const SizedBox(),
        toolbarHeight: 45,
        flexibleSpace: Container(
          height: double.infinity,
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
          decoration: BoxDecoration(
            color: primaryColor.shade900,
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIconButton(
                  icon: Icons.arrow_back,
                  size: CustomIconButtonSize.small,
                  variant: CustomIconButtonVariant.light,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: MediaQuery.of(context).size.width,
        color: primaryColor.shade900,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: ScrollShadow(
              color: Colors.black.withOpacity(0.1),
              size: 10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: primaryColor.shade900,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 16,
                        right: 16,
                        bottom: 60,
                      ),
                      height: Get.height * 0.3,
                      constraints: const BoxConstraints(
                        maxHeight: 190,
                        minHeight: 190,
                      ),
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Reset Password',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Enter the pin code that we sent in your email and set your password',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: primaryColor.shade900,
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 16,
                          right: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 5,
                              color: Colors.white,
                              blurRadius: 5,
                              offset: Offset(0, 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 30,
                        left: 16,
                        right: 16,
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            CustomTextField(
                              controller: controller.emailController,
                              validator: controller.validateEmail,
                              label: 'Email',
                              placeholder: 'Enter your email',
                              type: CustomTextFieldType.email,
                              isReadOnly: true,
                              prefix: CustomIcon(
                                icon: CustomIcons.mailIcon,
                                color: primaryColor.shade900,
                              ),
                            ),
                            CustomTextField(
                              controller: controller.otpController,
                              validator: controller.validateOtp,
                              label: 'OTP',
                              placeholder: 'Enter your OTP',
                              type: CustomTextFieldType.number,
                              prefix: CustomIcon(
                                icon: CustomIcons.otpIcon,
                                color: primaryColor.shade900,
                              ),
                            ),
                            CustomTextField(
                              controller: controller.passwordController,
                              validator: controller.validatePassword,
                              label: 'Password',
                              placeholder: 'Enter your password',
                              type: CustomTextFieldType.password,
                              prefix: CustomIcon(
                                icon: CustomIcons.passwordIcon,
                                color: primaryColor.shade900,
                              ),
                            ),
                            CustomTextField(
                              controller: controller.confirmPasswordController,
                              validator: controller.validateConfirmPassword,
                              label: 'Confirm Password',
                              placeholder: 'Enter your confirm password',
                              type: CustomTextFieldType.password,
                              prefix: CustomIcon(
                                icon: CustomIcons.passwordIcon,
                                color: primaryColor.shade900,
                              ),
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => CustomButton(
                                    onPressed: () {
                                      controller.submit();
                                    },
                                    text: 'Reset Password',
                                    loading: controller.isLoading,
                                    disabled: controller.isLoading,
                                    loadingText: 'Please wait...',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => CustomButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    text: 'Back',
                                    variant: CustomButtonVariant.gray,
                                    disabled: controller.isLoading,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
