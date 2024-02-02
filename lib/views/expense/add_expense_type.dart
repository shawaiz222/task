import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/expenses_controller.dart';

class AddExpenseTypeScreen extends StatefulWidget {
  const AddExpenseTypeScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseTypeScreen> createState() => _AddExpenseTypeScreenState();
}

class _AddExpenseTypeScreenState extends State<AddExpenseTypeScreen> {
  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  void dispose() {
    expensesController.resetTypeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: Text(
          'Add Expense Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
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
                key: expensesController.typeFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      controller: expensesController.typeNameController,
                      validator: expensesController.validateTypeName,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Description',
                      controller: expensesController.typeDescriptionController,
                      type: CustomTextFieldType.textarea,
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
                text: 'Create',
                onPressed: () {
                  expensesController.createExpenseType();
                },
                loading: expensesController.isLoading,
                disabled: expensesController.buttonDisabled ||
                    expensesController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
