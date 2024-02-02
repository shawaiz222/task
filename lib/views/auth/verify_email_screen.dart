import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import '../../components/ui/index.dart';
import '../../controllers/forms/auth/verify_email_controller.dart';
import '../../utils//custom_icons.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;
  final String? nextPath;
  const VerifyEmailScreen({Key? key, this.email, this.nextPath})
      : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final VerifyEmailFormController controller =
      Get.put(VerifyEmailFormController());

  @override
  void initState() {
    controller.emailController.text = widget.email ?? '';
    controller.nextPath.value = widget.nextPath ?? '/home';
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
                            'Verify your email',
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
                              'Please enter the OTP sent to your email address to verify your email',
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
                            Obx(
                              () => CustomButton(
                                onPressed: () {
                                  controller.submit();
                                },
                                text: 'Verify Email',
                                loading: controller.isLoading,
                                disabled: controller.isLoading ||
                                    controller.sendOtpLoading,
                                loadingText: 'Please wait...',
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    onPressed: () {
                                      Get.offAllNamed(
                                        controller.nextPath.value == '/home'
                                            ? '/login'
                                            : '/signup',
                                      );
                                    },
                                    text: 'Back',
                                    variant: CustomButtonVariant.gray,
                                    disabled: controller.isLoading ||
                                        controller.sendOtpLoading,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Obx(
                                    () => CustomButton(
                                      onPressed: () {
                                        controller.sendOtp();
                                      },
                                      text: 'Resend OTP',
                                      variant: CustomButtonVariant.outline,
                                      loading: controller.sendOtpLoading,
                                      disabled: controller.isLoading ||
                                          controller.sendOtpLoading,
                                      loadingText: 'Please wait...',
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
