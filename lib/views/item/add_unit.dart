import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/units_controller.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  State<AddUnitScreen> createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  final UnitsController unitsController = Get.put(UnitsController());

  @override
  void dispose() {
    unitsController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            unitsController.editId.value.isEmpty ? 'Add Unit' : 'Edit Unit',
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
                key: unitsController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      placeholder: 'Enter name',
                      controller: unitsController.nameController,
                      validator: unitsController.validateName,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Short Name',
                      placeholder: 'Enter short name',
                      controller: unitsController.shortNameController,
                      validator: unitsController.validateShortName,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Description',
                      placeholder: 'Enter description',
                      type: CustomTextFieldType.textarea,
                      controller: unitsController.descriptionController,
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
                text: unitsController.editId.value.isEmpty ? 'Create' : 'Save',
                onPressed: () {
                  unitsController.createUnit();
                },
                loading: unitsController.isLoading,
                disabled:
                    unitsController.buttonDisabled || unitsController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
