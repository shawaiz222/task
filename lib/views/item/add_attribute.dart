import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/controllers/forms/item/attributes_controller.dart';
import 'package:get/get.dart';

class AddAttributeScreen extends StatefulWidget {
  const AddAttributeScreen({Key? key}) : super(key: key);

  @override
  State<AddAttributeScreen> createState() => _AddAttributeScreenState();
}

class _AddAttributeScreenState extends State<AddAttributeScreen> {
  final AttributesController attributesController =
      Get.put(AttributesController());

  @override
  void dispose() {
    attributesController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            attributesController.editId.value.isEmpty
                ? 'Add Attribute'
                : 'Edit Attribute',
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
                key: attributesController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      placeholder: 'T-Shirt Size',
                      controller: attributesController.nameController,
                      validator: attributesController.validateName,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Display Name',
                      placeholder: 'Size',
                      controller: attributesController.displayNameController,
                      validator: attributesController.validateDisplayName,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Options',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ThemeColors.borderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: attributesController.values.length,
                              itemBuilder: (context, index) {
                                return CustomTextField(
                                  key: ValueKey(
                                      attributesController.values[index].id),
                                  hasBorder: false,
                                  placeholder: index ==
                                          attributesController.values.length - 1
                                      ? 'Add Option'
                                      : '',
                                  value:
                                      attributesController.values[index].name,
                                  onChanged: (value) {
                                    attributesController.setValue(value,
                                        attributesController.values[index].id);
                                  },
                                  suffix: index ==
                                          attributesController.values.length - 1
                                      ? null
                                      : InkWell(
                                          onTap: () {
                                            attributesController.removeValue(
                                                attributesController
                                                    .values[index].id);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 16,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
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
                text: attributesController.editId.value.isEmpty
                    ? 'Create'
                    : 'Save',
                onPressed: () {
                  attributesController.createAttribute();
                },
                loading: attributesController.isLoading,
                disabled: attributesController.buttonDisabled ||
                    attributesController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
