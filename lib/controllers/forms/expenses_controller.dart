// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/expense/expense_repository.dart';
import 'package:invoder_app/data/repositories/expense/expense_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/expense_models.dart';

class ExpensesController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  ExpenseRepository expenseRepository = Get.put(ExpenseRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> typeFormKey = GlobalKey<FormState>();
  final typeNameController = TextEditingController();
  final typeDescriptionController = TextEditingController();
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  final RxString _expenseType = ''.obs;
  final RxString _expenseDate = ''.obs;
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  final RxList<Map<String, dynamic>> _expenseTypes =
      <Map<String, dynamic>>[].obs;
  final RxList<ExpenseModel> _expenses = <ExpenseModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  String get expenseType => _expenseType.value;
  String get date => _expenseDate.value;
  List<Map<String, dynamic>> get expenseTypes => _expenseTypes.value;
  List<ExpenseModel> get expenses => _expenses.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;

  set expenseType(value) => _expenseType.value = value;
  set date(value) => _expenseDate.value = value;
  set buttonDisabled(value) => _buttonDisabled.value = value;
  set isLoading(value) => _isLoading.value = value;
  set expenseTypes(value) => _expenseTypes.value = value;
  set setExpenses(value) => _expenses.value = value;
  set page(value) => _page.value = value;
  set limit(value) => _limit.value = value;
  set nextPage(value) => _nextPage.value = value;
  set search(value) => search.value = value;
  set selectable(value) => _selectable.value = value;
  set selected(value) => _selected.value = value;
  set firstLoading(value) => _firstLoading.value = value;
  set loadMoreLoading(value) => _loadMoreLoading.value = value;

  bool get isLoading => _isLoading.value;
  bool get buttonDisabled => _buttonDisabled.value;

  void editExpense(id, type, amount, d, description) {
    editId.value = id;
    expenseType = type;
    amountController.text = amount.toString();
    date = d.toString();
    descriptionController.text = description;
  }

  void reset() {
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _expenses.value = [];
    _page.value = 1;
    _limit.value = 20;
    _nextPage.value = false;
    search.value = '';
    _firstLoading.value = true;
    _scrollController.dispose();
  }

  void resetForm() {
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    editId.value = '';
    expenseType = '';
    date = '';
    amountController.text = '';
    descriptionController.text = '';
  }

  void resetTypeForm() {
    typeFormKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    typeNameController.text = '';
    typeDescriptionController.text = '';
  }

  String? validateTypeName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value!.isEmpty) {
      return 'Amount is required';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value!.isEmpty) {
      return 'Date is required';
    }
    return null;
  }

  void updateExpense() {
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      expenseRepository
          .updateExpense(
        editId.value,
        UpdateExpenseParameters(
          type: expenseType,
          date: DateTime.parse(date),
          amount: double.parse(amountController.text),
          description: descriptionController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Expense updated successfully',
              type: SnackType.success,
            );
            getExpenses();
          } else {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          }
        },
      );
    }
  }

  void createExpense() {
    if (expenseType.isEmpty) {
      Snackbar.show(
        message: 'Expense type is required',
        type: SnackType.error,
      );
      return;
    }
    if (editId.isNotEmpty) {
      updateExpense();
      return;
    }
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      expenseRepository
          .createExpense(
        CreateExpenseParameters(
          type: expenseType,
          date: DateTime.parse(date),
          amount: double.parse(amountController.text),
          description: descriptionController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Get.back();
            Snackbar.show(
              message: 'Expense created successfully',
              type: SnackType.success,
            );
            editId.value = value.data['id'];
            getExpenses();
          } else {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          }
        },
      );
    }
  }

  void getExpenses() {
    _isLoading.value = true;
    expenseRepository
        .getExpenses(
      GetExpensesQueryParameters(
        page: page,
        limit: limit,
      ),
    )
        .then(
      (value) {
        _isLoading.value = false;
        _firstLoading.value = false;
        if (!value.error) {
          _expenses.value = value.data['docs']
              .map<ExpenseModel>((e) => ExpenseModel.fromMap(e))
              .toList();
          nextPage = value.data['nextPage'] != null;
        } else {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );
        }
      },
    );
  }

  void getExpenseTypes() {
    expenseRepository.getExpenseTypes().then(
      (value) {
        if (!value.error) {
          _expenseTypes.value = value.data.map<Map<String, dynamic>>(
            (e) {
              return {
                'label': e['name'],
                'value': e['id'],
              };
            },
          ).toList();
        } else {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );
        }
      },
    );
  }

  void loadMore() {
    if (nextPage && !isLoading) {
      nextPage = false;
      loadMoreLoading = true;
      page = page + 1;
      expenseRepository
          .getExpenses(
        GetExpensesQueryParameters(
          page: page,
          limit: limit,
        ),
      )
          .then(
        (value) {
          loadMoreLoading = false;
          if (!value.error) {
            var n = value.data['docs']
                .map<ExpenseModel>((e) => ExpenseModel.fromMap(e))
                .toList();
            _expenses.value = [..._expenses.value, ...n];

            Future.delayed(const Duration(milliseconds: 1000), () {
              nextPage = value.data['nextPage'] != null;
            });
          } else {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          }
        },
      );
    }
  }

  void init() {
    getExpenses();
    getExpenseTypes();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteExpense() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Expense',
        middleText: 'Are you sure you want to delete this expense?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          expenseRepository
              .deleteExpense(
            DeleteExpenseParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Expense deleted successfully',
                  type: SnackType.success,
                );
                getExpenses();
                selectable = false;
                selected = List<String>.empty();
              } else {
                Snackbar.show(
                  message: value.message ?? 'Something went wrong',
                  type: SnackType.error,
                );
              }
            },
          );
        },
      );
    }
  }

  void createExpenseType() {
    if (typeFormKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      expenseRepository
          .createExpenseType(
        CreateExpenseTypeParameters(
          name: typeNameController.text,
          description: typeDescriptionController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Get.back();
            Snackbar.show(
              message: 'Expense type created successfully',
              type: SnackType.success,
            );
            getExpenseTypes();
            resetTypeForm();
          } else {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          }
        },
      );
    }
  }
}
