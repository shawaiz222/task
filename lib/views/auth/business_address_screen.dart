import 'package:flutter/material.dart';
import '../../controllers/forms/auth/buissness_details_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:invoder_app/utils/colors.dart';
import '../../components/ui/index.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';

class BusinessAddressScreen extends StatefulWidget {
  const BusinessAddressScreen({Key? key}) : super(key: key);

  @override
  State<BusinessAddressScreen> createState() => _BusinessAddressScreenState();
}

class _BusinessAddressScreenState extends State<BusinessAddressScreen> {
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
                const Text(
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
            child: Column(
              children: [
                Expanded(
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
                                  'Business Address Details',
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
                                  'Enter your business Address details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
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
                              key: controller.addressFormKey,
                              child: Obx(
                                () => Wrap(
                                  runSpacing: 20,
                                  spacing: 20,
                                  children: [
                                    CustomCheckBox(
                                      label:
                                          'Dont have permanent physical location',
                                      value: controller.isOnlineBusiness,
                                      onChanged: (value) {
                                        controller.setIsOnlineBusiness(value);
                                      },
                                    ),
                                    CustomTextField(
                                      controller:
                                          controller.buissnessCountryController,
                                      validator:
                                          controller.validateBuissnessCountry,
                                      label: 'Country',
                                      placeholder: 'Select country',
                                    ),
                                    CustomTextField(
                                      controller:
                                          controller.buissnessAddressController,
                                      validator:
                                          controller.validateBuissnessAddress,
                                      label: 'Address',
                                      placeholder:
                                          'Enter your buissness address',
                                      isReadOnly: controller.isOnlineBusiness,
                                    ),
                                    CustomTextField(
                                      controller:
                                          controller.buissnessCityController,
                                      validator:
                                          controller.validateBuissnessCity,
                                      label: 'City',
                                      placeholder: 'Enter city',
                                      isReadOnly: controller.isOnlineBusiness,
                                    ),
                                    CustomTextField(
                                      controller:
                                          controller.buissnessStateController,
                                      validator:
                                          controller.validateBuissnessState,
                                      label: 'State',
                                      placeholder: 'Enter state',
                                      isReadOnly: controller.isOnlineBusiness,
                                    ),
                                    CustomTextField(
                                      controller:
                                          controller.buissnessZipController,
                                      validator:
                                          controller.validateBuissnessZip,
                                      label: 'Zip',
                                      placeholder: 'Enter zip code',
                                      isReadOnly: controller.isOnlineBusiness,
                                    ),
                                    Column(
                                      children: [
                                        CustomButton(
                                          onPressed: () {
                                            controller.submitAddress();
                                          },
                                          text: 'Lets begin',
                                          loading: controller.isLoading,
                                          disabled: controller.isLoading,
                                          loadingText: 'Creating Company...',
                                        ),
                                        const SizedBox(height: 10),
                                        CustomButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          text: 'Back',
                                          variant: CustomButtonVariant.gray,
                                          disabled: controller.isLoading,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
