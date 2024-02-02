// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/item/item_parameters.dart';
import 'package:invoder_app/data/repositories/item/item_repository.dart';
import 'package:invoder_app/data/repositories/item/attribute/attribute_repository.dart';
import 'package:invoder_app/data/repositories/item/attribute/attribute_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/item_models.dart';
import 'package:invoder_app/data/repositories/data_repository.dart';
import 'package:invoder_app/views/item/edit_variation.dart';
import 'package:invoder_app/data/models/common_models.dart';
import 'package:invoder_app/controllers/forms/item/products_controller.dart';

class VariationController extends GetxController {
  final ProductsController productsController = Get.put(ProductsController());
  final box = GetStorage();
  final DataRepository dataRepository = Get.put(DataRepository());
  final AttributeRepository attributeRepository =
      Get.put(AttributeRepository());
  ItemRepository itemRepository = Get.put(ItemRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool _isProductVariation = true.obs;
  final RxInt _stock = 0.obs;
  final Rxn<ImageModel> _image = Rxn<ImageModel>();
  final RxList<AttributeModel> _attributesList = <AttributeModel>[].obs;
  final RxList<Map<String, dynamic>> _variables = <Map<String, dynamic>>[].obs;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final skuController = TextEditingController();
  final barcodeController = TextEditingController();
  final _itemId = ''.obs;
  final _editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;

  bool get isProductVariation => _isProductVariation.value;
  int get stock => _stock.value;
  List<Map<String, dynamic>> get variables => _variables.value;
  String get itemId => _itemId.value;
  String get editId => _editId.value;
  bool get isLoading => _isLoading.value;
  bool get buttonDisabled => _buttonDisabled.value;
  List<AttributeModel> get attributesList => _attributesList.value;
  ImageModel? get image => _image.value;

  set isProductVariation(value) => _isProductVariation.value = value;
  set stock(value) => _stock.value = value;
  set variables(value) => _variables.value = value;
  set itemId(value) => _itemId.value = value;
  set editId(value) => _editId.value = value;
  set isLoading(value) => _isLoading.value = value;
  set buttonDisabled(value) => _buttonDisabled.value = value;
  set attributesList(value) => _attributesList.value = value;
  set image(value) => _image.value = value;

  void reset() {
    formKey = GlobalKey<FormState>();
    isLoading = false;
    buttonDisabled = false;
    editId = '';
    itemId = '';
    priceController.text = '';
    skuController.text = '';
    barcodeController.text = '';
    stock = 0;
    variables = [];
    attributesList = [];
  }

  void editVariation(Map<String, dynamic> variation) {
    editId = variation['id'];
    priceController.text = variation['price'] ?? '';
    skuController.text = variation['sku'] ?? '';
    barcodeController.text = variation['barcode'] ?? '';
    stock = variation['stock'] ?? 0;
    nameController.text = generateVariationName(variation);
    image = variation['image'] != null
        ? ImageModel.fromMap(variation['image'])
        : ImageModel();
  }

  void updateVariation() async {
    if (variables.every((e) => e['value'] != null)) {
      buttonDisabled = true;
      isLoading = true;
      UpdateItemVariationParameters body = UpdateItemVariationParameters(
        price: priceController.text.isNotEmpty
            ? double.parse(priceController.text)
            : null,
        sku: skuController.text,
        barcode: barcodeController.text,
        image: image,
      );
      itemRepository.updateVariation(body, itemId, editId).then(
        (value) {
          buttonDisabled = false;
          isLoading = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Variation updated successfully',
              type: SnackType.success,
            );
            var product = ProductModel.fromMap(value.data);
            productsController.productVariations = product.variations;
            productsController.getProducts();
          } else {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          }
        },
      );
    } else {
      Snackbar.show(
        message: 'Please select all attributes',
        type: SnackType.error,
      );
    }
  }

  void createVariation() async {
    var previousVariations = productsController.productVariations;
    var variationVariables = previousVariations
        .map((e) => e['variables']
            .map((e) => {
                  'attribute': e['attribute']['id'],
                  'value': e['value'],
                })
            .toList()
            .toString())
        .toList();
    // check if variation already exists
    if (variationVariables.contains(variables.toString())) {
      Snackbar.show(
        message: 'Variation already exists',
        type: SnackType.error,
      );
      return;
    }
    if (variables.every((e) => e['value'] != null)) {
      buttonDisabled = true;
      isLoading = true;
      CreateItemVariationParameters body = CreateItemVariationParameters(
        variables: variables,
      );
      itemRepository.createVariation(body, itemId).then(
        (value) {
          buttonDisabled = false;
          isLoading = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Variation created successfully',
              type: SnackType.success,
            );
            Get.off(
              () => EditVariationScreen(
                itemId: itemId,
                variation: value.data['variations']
                    [value.data['variations'].length - 1],
              ),
            );
            var product = ProductModel.fromMap(value.data);
            productsController.productVariations = product.variations;
            productsController.getProducts();
          } else {
            Snackbar.show(
              message: value.message ?? 'Something went wrong',
              type: SnackType.error,
            );
          }
        },
      );
    } else {
      Snackbar.show(
        message: 'Please select all attributes',
        type: SnackType.error,
      );
    }
  }

  void deleteVariation() async {
    Get.defaultDialog(
      title: 'Delete Variation',
      middleText: 'Are you sure you want to delete this variation?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      backgroundColor: Colors.white,
      confirmTextColor: Colors.white,
      onConfirm: () {
        _isLoading.value = true;
        itemRepository
            .deleteVariation(
          itemId,
          editId,
        )
            .then(
          (value) {
            Get.back();
            _isLoading.value = false;
            if (!value.error) {
              productsController.productVariations = productsController
                  .productVariations
                  .where((element) => element['id'] != editId)
                  .toList();
              productsController.getProducts();
              Get.back();
              Snackbar.show(
                message: 'Variation deleted successfully',
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
      },
    );
  }

  void onStockUpdated(int e) {
    stock = e;
    var variation = productsController.productVariations
        .firstWhere((element) => element['id'] == editId);
    variation['stock'] = e;
    productsController.productVariations = productsController.productVariations
        .map((e) => e['id'] == editId ? variation : e)
        .toList();
    productsController.getProducts();
  }

  void getAttributes(List<String> ids) async {
    _isLoading.value = true;
    _buttonDisabled.value = true;
    attributeRepository
        .getAttributes(GetAttributesQueryParameters(ids: ids, limit: 1000))
        .then(
      (value) {
        _isLoading.value = false;
        _buttonDisabled.value = false;
        if (!value.error) {
          attributesList = value.data['docs']
              .map<AttributeModel>((e) => AttributeModel.fromMap(e))
              .toList();
          variables = value.data['docs']
              .map<Map<String, dynamic>>(
                (e) => {
                  'attribute': e['id'],
                  'value': null,
                },
              )
              .toList();
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
