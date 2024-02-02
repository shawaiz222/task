import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import '../../components/ui/index.dart';
import '../../controllers/forms/auth/login_controller.dart';
import '../../utils//custom_icons.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginFormController controller = Get.put(LoginFormController());

  @override
  void dispose() {
    controller.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(),
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
                        bottom: 30,
                      ),
                      height: Get.height * 0.3,
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                        minHeight: 200,
                      ),
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hi, Welcome Back',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 400,
                            child: Text(
                              'Sign in now to access back your account and the whole features!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              textAlign: TextAlign.center,
                            ),
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 500,
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
                              prefix: CustomIcon(
                                icon: CustomIcons.mailIcon,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed('/forgot-password');
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => CustomButton(
                                onPressed: () {
                                  controller.submit();
                                },
                                text: 'Sign in',
                                loading: controller.isLoading,
                                disabled: controller.isLoading,
                                loadingText: 'Signing in...',
                              ),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: primaryColor.shade900,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offNamed('/signup');
                                  },
                                  child: Text(
                                    ' Sign up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
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
