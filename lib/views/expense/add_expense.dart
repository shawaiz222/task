import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/expenses_controller.dart';
import './add_expense_type.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  void initState() {
    super.initState();
    if (expensesController.editId.isEmpty) {
      expensesController.date = DateTime.now().toString();
    }
  }

  @override
  void dispose() {
    expensesController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            expensesController.editId.value.isEmpty
                ? 'Add Expense'
                : 'Edit Expense',
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
                key: expensesController.formKey,
                child: Column(
                  children: [
                    Obx(
                      () => CustomSelectField(
                        label: 'Type',
                        onChanged: (s) {
                          expensesController.expenseType = s;
                        },
                        placeholder: 'Select Type',
                        value: expensesController.expenseType,
                        items: expensesController.expenseTypes,
                        variant: CustomSelectFieldVariant.lableOutside,
                        customHeaderAction: IconButton(
                          onPressed: () {
                            Get.to(() => const AddExpenseTypeScreen());
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Amount',
                      placeholder: '0.00',
                      prefix: const Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      controller: expensesController.amountController,
                      type: CustomTextFieldType.number,
                      validator: expensesController.validateAmount,
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomDatePicker(
                        label: 'Date',
                        value: expensesController.date,
                        placeholder: 'Select Date',
                        onChanged: (s) {
                          expensesController.date = s;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Description',
                      placeholder: 'Enter Description',
                      controller: expensesController.descriptionController,
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
                text:
                    expensesController.editId.value.isEmpty ? 'Create' : 'Save',
                onPressed: () {
                  expensesController.createExpense();
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
