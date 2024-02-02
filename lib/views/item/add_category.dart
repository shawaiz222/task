import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/categories_controller.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  void dispose() {
    categoriesController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            categoriesController.editId.value.isEmpty
                ? 'Add Category'
                : 'Edit Category',
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
                key: categoriesController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      placeholder: 'Enter name',
                      controller: categoriesController.nameController,
                      validator: categoriesController.validateName,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Description',
                      placeholder: 'Enter description',
                      type: CustomTextFieldType.textarea,
                      controller: categoriesController.descriptionController,
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
                text: categoriesController.editId.value.isEmpty
                    ? 'Create'
                    : 'Save',
                onPressed: () {
                  categoriesController.createCategory();
                },
                loading: categoriesController.isLoading,
                disabled: categoriesController.buttonDisabled ||
                    categoriesController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
