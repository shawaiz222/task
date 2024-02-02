import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoder_app/utils/colors.dart';
import '../../components/ui/index.dart';
import '../../controllers/forms/auth/buissness_details_controller.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';

class BusinessDetailScreen extends StatefulWidget {
  const BusinessDetailScreen({Key? key}) : super(key: key);

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  final BuissnessDetailsFormController controller =
      Get.put(BuissnessDetailsFormController());

  @override
  void dispose() {
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
          child: const SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(),
                Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
                            'Business Details',
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
                            'Enter your business details',
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
                        bottom: 10,
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
                            FormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: controller.validateBuissnessType,
                              initialValue: controller.buissnessType,
                              builder: (FormFieldState state) {
                                return CustomSelectField(
                                  label: 'Buissness Type',
                                  placeholder: 'Select buissness type',
                                  value: state.value,
                                  items: controller.buissnessTypes,
                                  onChanged: (value) {
                                    controller.setBuissnessType(value);
                                    state.didChange(value);
                                  },
                                  error: state.errorText,
                                  variant:
                                      CustomSelectFieldVariant.lableOutside,
                                );
                              },
                            ),
                            CustomTextField(
                              controller: controller.buissnessNameController,
                              validator: controller.validateBuissnessName,
                              label: 'Buissness Name',
                              placeholder: 'Enter your buissness name',
                            ),
                            CustomTextField(
                              controller: controller.buissnessEmailController,
                              validator: controller.validateBuissnessEmail,
                              label: 'Buissness Email',
                              placeholder: 'Enter your buissness email',
                              type: CustomTextFieldType.email,
                            ),
                            CustomTextField(
                              controller: controller.buissnessPhoneController,
                              validator: controller.validateBuissnessPhone,
                              label: 'Buissness Phone',
                              placeholder: 'Enter your buissness phone',
                              type: CustomTextFieldType.phone,
                            ),
                            CustomButton(
                              onPressed: () {
                                controller.submitDetail();
                              },
                              text: 'Next',
                              loading: controller.isLoading,
                              disabled: controller.isLoading,
                              loadingText: 'Creating Company...',
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
