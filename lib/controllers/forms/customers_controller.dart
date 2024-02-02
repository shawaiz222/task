// ignore_for_file: invalid_use_of_protected_member

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/customer/customer_repository.dart';
import 'package:invoder_app/data/repositories/customer/customer_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/customer_models.dart';

class CustomersController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  CustomerRepository customerRepository = Get.put(CustomerRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;
  RxString selectedCountryCode = '+92'.obs;
  void onSelectCountry(CountryCode countryCode) {
    selectedCountryCode.value = '+${countryCode.code}';
  }

  final RxList<Map<String, dynamic>> _customerTypes =
      <Map<String, dynamic>>[].obs;
  final RxList<CustomerModel> _customers = <CustomerModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  List<CustomerModel> get customers => _customers.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;

  set buttonDisabled(value) => _buttonDisabled.value = value;
  set isLoading(value) => _isLoading.value = value;
  set customerTypes(value) => _customerTypes.value = value;
  set setCustomers(value) => _customers.value = value;
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

  void editCustomer(id, name, email, phone, address) {
    editId.value = id;
    nameController.text = name;
    emailController.text = email ?? '';
    phoneController.text = phone ?? '';
    addressController.text = address ?? '';
  }

  void reset() {
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _customers.value = [];
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
    nameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    addressController.text = '';
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  void updateCustomer() {
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      customerRepository
          .updateCustomer(
        editId.value,
        UpdateCustomerParameters(
          name: nameController.text,
          email: emailController.text,
          extention: selectedCountryCode.toString(),
          phone: phoneController.text,
          address: addressController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Customer updated successfully',
              type: SnackType.success,
            );
            getCustomers();
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

  void createCustomer() {
    if (editId.isNotEmpty) {
      updateCustomer();
      return;
    }
    if (formKey.currentState!.validate()) {
      if (emailController.text.isNotEmpty) {
        if (!GetUtils.isEmail(emailController.text)) {
          Snackbar.show(
              message: "Invalid Email Address", type: SnackType.error);

          return;
        }
      }
      _buttonDisabled.value = true;
      _isLoading.value = true;
      customerRepository
          .createCustomer(
        CreateCustomerParameters(
          name: nameController.text,
          email: emailController.text,
          extention: selectedCountryCode.toString(),
          phone: phoneController.text,
          address: addressController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Get.back();
            Snackbar.show(
              message: 'Customer created successfully',
              type: SnackType.success,
            );
            editId.value = value.data['id'];
            getCustomers();
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

  void getCustomers() {
    _isLoading.value = true;
    customerRepository
        .getCustomers(
      GetCustomersQueryParameters(
        page: page,
        limit: limit,
        search: search.value,
      ),
    )
        .then(
      (value) {
        _isLoading.value = false;
        _firstLoading.value = false;
        if (!value.error) {
          _customers.value = value.data['docs']
              .map<CustomerModel>((e) => CustomerModel.fromMap(e))
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

  void loadMore() {
    if (nextPage && !isLoading) {
      nextPage = false;
      loadMoreLoading = true;
      page = page + 1;
      customerRepository
          .getCustomers(
        GetCustomersQueryParameters(
          page: page,
          limit: limit,
          search: search.value,
        ),
      )
          .then(
        (value) {
          loadMoreLoading = false;
          if (!value.error) {
            var n = value.data['docs']
                .map<CustomerModel>((e) => CustomerModel.fromMap(e))
                .toList();
            _customers.value = [..._customers.value, ...n];

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
    getCustomers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteCustomer() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Customer',
        middleText: 'Are you sure you want to delete this customer?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          customerRepository
              .deleteCustomer(
            DeleteCustomerParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Customer deleted successfully',
                  type: SnackType.success,
                );
                getCustomers();
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
}
