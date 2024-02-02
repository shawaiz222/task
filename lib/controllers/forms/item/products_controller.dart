// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/item/item_repository.dart';
import 'package:invoder_app/data/repositories/item/item_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/item_models.dart';
import 'package:invoder_app/data/models/common_models.dart';
import 'package:invoder_app/data/repositories/data_repository.dart';
import 'package:invoder_app/views/item/select_attributes.dart';
import 'package:invoder_app/views/item/select_variation.dart';

String generateVariationName(Map<String, dynamic> data) {
  List<String> attributes = [];

  for (var variable in data['variables']) {
    String attributeValue = variable['attribute']['values']
        .firstWhere((value) => value['id'] == variable['value'])['name'];

    attributes.add(attributeValue);
  }

  String name = attributes.join(', ');

  return name;
}

class ProductsController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  final DataRepository dataRepository = Get.put(DataRepository());
  ItemRepository productRepository = Get.put(ItemRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<Map<String, dynamic>> _types = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _categories = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _units = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _attributes = <Map<String, dynamic>>[].obs;
  final RxString _type = 'simple'.obs;
  final RxString _category = ''.obs;
  final RxList<dynamic> _productAttributes = <dynamic>[].obs;
  final RxList<dynamic> _productVariations = <dynamic>[].obs;
  final RxString _unit = ''.obs;
  final RxBool _nonTaxable = false.obs;
  final RxInt _stock = 0.obs;
  final Rxn<ImageModel> _image = Rxn<ImageModel>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final skuController = TextEditingController();
  final barcodeController = TextEditingController();
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = true.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  final RxList<ProductModel> _products = <ProductModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  List<ProductModel> get products => _products.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;
  List<Map<String, dynamic>> get types => _types.value;
  List<Map<String, dynamic>> get categories => _categories.value;
  List<Map<String, dynamic>> get units => _units.value;
  List<Map<String, dynamic>> get attributes => _attributes.value;
  List<dynamic> get productAttributes => _productAttributes.value;
  List<dynamic> get productVariations => _productVariations.value;
  String get type => _type.value;
  String get category => _category.value;
  String get unit => _unit.value;
  bool get nonTaxable => _nonTaxable.value;
  int get stock => _stock.value;
  ImageModel? get image => _image.value;

  set setProducts(value) => _products.value = value;
  set page(value) => _page.value = value;
  set limit(value) => _limit.value = value;
  set nextPage(value) => _nextPage.value = value;
  set search(value) => search.value = value;
  set selectable(value) => _selectable.value = value;
  set selected(value) => _selected.value = value;
  set firstLoading(value) => _firstLoading.value = value;
  set loadMoreLoading(value) => _loadMoreLoading.value = value;
  set types(value) => _types.value = value;
  set categories(value) => _categories.value = value;
  set units(value) => _units.value = value;
  set attributes(value) => _attributes.value = value;
  set productVariations(value) => _productVariations.value = value;
  set productAttributes(value) => _productAttributes.value = value;
  set type(value) => _type.value = value;
  set category(value) => _category.value = value;
  set unit(value) => _unit.value = value;
  set buttonDisabled(value) => _buttonDisabled.value = value;
  set nonTaxable(value) => _nonTaxable.value = value;
  set stock(value) => _stock.value = value;
  set image(value) => _image.value = value;

  bool get isLoading => _isLoading.value;
  bool get buttonDisabled => _buttonDisabled.value;

  void setName(String value) => nameController.text = value;
  void setDescription(String value) => descriptionController.text = value;
  void setPrice(String value) => priceController.text = value;
  void setSku(String value) => skuController.text = value;
  void setBarcode(String value) => barcodeController.text = value;

  void editProduct(id) {
    editId.value = id;
    var product = products.firstWhere((element) => element.id == id);
    nameController.text = product.name;
    descriptionController.text = product.description ?? '';
    type = product.type;
    category = product.category ?? '';
    unit = product.unit ?? '';
    skuController.text = product.sku ?? '';
    barcodeController.text = product.barcode ?? '';
    priceController.text =
        product.price != null ? product.price.toString() : '';
    nonTaxable = product.nonTaxable ?? false;
    stock = product.stock ?? 0;
    image = product.image;
    _productAttributes.value = product.attributes ?? List.empty();
    _productVariations.value = product.variations ?? List.empty();
  }

  void reset() {
    nameController.text = '';
    descriptionController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _products.value = [];
    _page.value = 1;
    _limit.value = 20;
    _nextPage.value = false;
    search.value = '';
    _firstLoading.value = true;
    _scrollController.dispose();
  }

  void resetForm() {
    nameController.text = '';
    descriptionController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    editId.value = '';
    type = 'simple';
    category = '';
    unit = '';
    skuController.text = '';
    barcodeController.text = '';
    priceController.text = '';
    nonTaxable = false;
    stock = 0;
    _productAttributes.value = [];
  }

  void updateProduct() {
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      productRepository
          .updateItem(
        UpdateItemParameters(
          image: image,
          type: type,
          name: nameController.text,
          category: category,
          unit: unit,
          description: descriptionController.text,
          sku: skuController.text,
          barcode: barcodeController.text,
          price: priceController.text.isNotEmpty
              ? double.parse(priceController.text)
              : null,
          nonTaxable: nonTaxable,
          attributes: List<String>.from(productAttributes),
        ),
        editId.value,
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Product updated successfully',
              type: SnackType.success,
            );
            getProducts();
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

  void updateAttributes() {
    productRepository
        .updateItem(
      UpdateItemParameters(
        attributes: List<String>.from(productAttributes),
      ),
      editId.value,
    )
        .then(
      (value) {
        getProducts();
      },
    );
  }

  void createProduct() {
    if (type.isNotEmpty) {
      productRepository
          .createItem(
        CreateItemParameters(
          itemType: 'product',
          type: type,
        ),
      )
          .then(
        (value) {
          if (!value.error) {
            _buttonDisabled.value = false;
            editId.value = value.data['id'];
            getProducts();
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

  void addVariation() {
    if (productAttributes.isEmpty) {
      Get.to(
        () => const SelectAttributesScreen(),
      );
    } else {
      Get.to(
        () => SelectVariationScreen(
          ids: List<String>.from(productAttributes),
          itemId: editId.value,
        ),
      );
    }
  }

  void getProducts() {
    _isLoading.value = true;
    productRepository
        .getItems(
      GetItemsQueryParameters(
        itemType: 'product',
        page: page,
        limit: limit,
        search: search.value,
      ),
    )
        .then(
      (value) {
        _isLoading.value = false;
        firstLoading = false;
        if (!value.error) {
          _products.value = value.data['docs']
              .map<ProductModel>((e) => ProductModel.fromMap(e))
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
      productRepository
          .getItems(
        GetItemsQueryParameters(
          itemType: 'product',
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
                .map<ProductModel>((e) => ProductModel.fromMap(e))
                .toList();
            _products.value = [..._products.value, ...n];

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

  void getTypes() {
    dataRepository
        .getData(
      'product-service-types',
    )
        .then(
      (value) {
        if (!value.error) {
          types = value.data.map<Map<String, dynamic>>(
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

  void getCategories() {
    dataRepository.categoriesOptions().then(
      (value) {
        if (!value.error) {
          _categories.value = value.data.map<Map<String, dynamic>>(
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

  void getUnits() {
    dataRepository.unitsOptions().then(
      (value) {
        if (!value.error) {
          _units.value = value.data.map<Map<String, dynamic>>(
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

  void getAttributes() {
    dataRepository.attributesOptions().then(
      (value) {
        if (!value.error) {
          _attributes.value = value.data.map<Map<String, dynamic>>(
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

  void init() {
    getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getTypes();
    getCategories();
    getUnits();
    getAttributes();
  }

  void deleteProduct() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Product',
        middleText: 'Are you sure you want to delete this product?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          productRepository
              .deleteItem(
            DeleteItemParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Product deleted successfully',
                  type: SnackType.success,
                );
                getProducts();
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
