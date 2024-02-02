import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/customers_controller.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final CustomersController customersController =
      Get.put(CustomersController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    customersController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            customersController.editId.value.isEmpty
                ? 'Add Customer'
                : 'Edit Customer',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: customersController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      controller: customersController.nameController,
                      validator: customersController.validateName,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Email',
                      controller: customersController.emailController,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Phone",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8)),
                                // alignment: Alignment.centerLeft,
                                child: CountryCodePicker(
                                  padding: EdgeInsets.all(5),
                                  showFlagMain: true,
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  flagWidth: 25,
                                  showFlag: true,
                                  onChanged: (CountryCode countryCode) {
                                    customersController
                                        .onSelectCountry(countryCode);
                                  },
                                  initialSelection:
                                      'PK', // Initial country code
                                  favorite: ['+92'], // Favorite country codes
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            label: 'Phone',
                            controller: customersController.phoneController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Address',
                      controller: customersController.addressController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 15),
            child: Obx(
              () => CustomButton(
                text: customersController.editId.value.isEmpty
                    ? 'Create'
                    : 'Save',
                onPressed: () {
                  customersController.createCustomer();
                },
                loading: customersController.isLoading,
                disabled: customersController.buttonDisabled ||
                    customersController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
