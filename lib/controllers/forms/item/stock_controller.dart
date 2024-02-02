// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/item/item_repository.dart';
import 'package:invoder_app/data/repositories/item/item_parameters.dart';
import 'package:invoder_app/data/repositories/data_repository.dart';
import 'package:invoder_app/utils/snackbar.dart';

class StocksController extends GetxController {
  final box = GetStorage();
  ItemRepository itemRepository = Get.put(ItemRepository());
  DataRepository dataRepository = Get.put(DataRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final valueController = TextEditingController();
  final RxString _reason = ''.obs;
  final RxList<Map<String, dynamic>> _reasons = <Map<String, dynamic>>[].obs;
  final itemId = ''.obs;
  final variationId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final Rx<Function> _onStockUpdated = Rx<Function>(() {});

  bool get isLoading => _isLoading.value;
  bool get buttonDisabled => _buttonDisabled.value;
  String get reason => _reason.value;
  List<Map<String, dynamic>> get reasons => _reasons.value;
  Function get onStockUpdated => _onStockUpdated.value;

  set reason(value) => _reason.value = value;
  set reasons(value) => _reasons.value = value;
  set onStockUpdated(Function value) => _onStockUpdated.value = value;

  void setValue(String value) => valueController.text = value;
  void reset() {
    valueController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
  }

  void resetForm() {
    valueController.text = '';
    reason = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    itemId.value = '';
    variationId.value = '';
  }

  String? validateValue(String? value) {
    if (value!.isEmpty) {
      return 'Value is required';
    }
    return null;
  }

  void getReasons() {
    _isLoading.value = true;
    dataRepository
        .getData(
      'stock-reasons',
    )
        .then(
      (value) {
        _isLoading.value = false;
        if (!value.error) {
          reasons = value.data.map<Map<String, dynamic>>(
            (e) {
              return {
                'label': e['label'],
                'value': e['key'],
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

  void init() {
    getReasons();
  }

  void updateStock() {
    if (reason.isEmpty) {
      Snackbar.show(
        message: 'Reason is required',
        type: SnackType.error,
      );
      return;
    }
    if (formKey.currentState!.validate() &&
        itemId.value.isNotEmpty &&
        reason.isNotEmpty) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      itemRepository
          .updateItemStock(
        UpdateItemStockParameters(
          reason: reason,
          value: double.parse(valueController.text),
        ),
        itemId.value,
        variationId.value,
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            int newStock = 0;
            if (variationId.value.isEmpty) {
              newStock = int.parse(value.data['stock']?.toString() ?? '0');
            } else {
              var variations = value.data['variations'];
              var variation = variations.firstWhere(
                (element) => element['id'] == variationId.value,
              );
              newStock = int.parse(variation['stock']?.toString() ?? '0');
            }
            onStockUpdated(newStock);
            resetForm();
            Get.back();
            Snackbar.show(
              message: value.message ?? 'Stock updated successfully',
              type: SnackType.success,
            );
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
