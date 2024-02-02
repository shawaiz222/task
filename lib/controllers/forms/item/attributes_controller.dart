// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/item/attribute/attribute_repository.dart';
import 'package:invoder_app/data/repositories/item/attribute/attribute_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:uuid/uuid.dart';
import 'package:invoder_app/data/models/item_models.dart';

class AttributesController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  AttributeRepository attributeRepository = Get.put(AttributeRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final displayNameController = TextEditingController();
  final _values = <AttributeValueModel>[
    AttributeValueModel(
      name: '',
      isNew: true,
      id: const Uuid().v4(),
    ),
  ].obs;
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  List<AttributeValueModel> get values => _values.value;

  set values(value) => _values.value = value;

  final RxList<AttributeModel> _attributes = <AttributeModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  List<AttributeModel> get attributes => _attributes.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;

  set setAttributes(value) => _attributes.value = value;
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

  void setName(String value) => nameController.text = value;
  void setShortName(String value) => displayNameController.text = value;
  void setValue(String value, String id) {
    var index = _values.indexWhere((element) => element.id == id);
    if (value.isNotEmpty && index == _values.length - 1) {
      _values.add(
          AttributeValueModel(name: '', isNew: true, id: const Uuid().v4()));
    }
    _values[index].name = value;
  }

  void removeValue(String id) {
    _values.removeWhere((element) => element.id == id);
  }

  void editAttribute(id, name, displayName, values) {
    editId.value = id;
    nameController.text = name;
    displayNameController.text = displayName;
    _values.value = [
      ...values,
      AttributeValueModel(
        name: '',
        isNew: true,
        id: const Uuid().v4(),
      ),
    ];
  }

  void reset() {
    nameController.text = '';
    displayNameController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _attributes.value = [];
    _page.value = 1;
    _limit.value = 20;
    _nextPage.value = false;
    search.value = '';
    _firstLoading.value = true;
    _scrollController.dispose();
  }

  void resetForm() {
    nameController.text = '';
    displayNameController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    editId.value = '';
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateDisplayName(String? value) {
    if (value!.isEmpty) {
      return 'Display Name is required';
    }
    return null;
  }

  String? validateValues(List<AttributeValueModel> value) {
    if (value.isEmpty) {
      return 'At least one option is required';
    }
    return null;
  }

  void createAttribute() {
    if (editId.value.isNotEmpty &&
        formKey.currentState!.validate() &&
        _values.length > 1) {
      updateAttribute();
    } else if (formKey.currentState!.validate() && _values.length > 1) {
      _isLoading.value = true;
      // remove empty values from list and remove id and isNew from values
      var v = _values.where((element) => element.name.isNotEmpty).toList();
      attributeRepository
          .createAttribute(
        CreateAttributeParameters(
            name: nameController.text,
            displayName: displayNameController.text,
            values: v),
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (!value.error) {
            editId.value = value.data['id'];
            Snackbar.show(
              message: 'Attribute created successfully',
              type: SnackType.success,
            );
            getAttributes();
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
        message: 'At least one option is required',
        type: SnackType.error,
      );
    }
  }

  void updateAttribute() {
    if (formKey.currentState!.validate() && editId.value.isNotEmpty) {
      _isLoading.value = true;
      var v = _values.where((element) => element.name.isNotEmpty).toList();
      attributeRepository
          .updateAttribute(
        UpdateAttributeParameters(
          name: nameController.text,
          displayName: displayNameController.text,
          values: v,
        ),
        editId.value,
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Attribute updated successfully',
              type: SnackType.success,
            );
            getAttributes();
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

  void getAttributes() {
    _isLoading.value = true;
    attributeRepository
        .getAttributes(
      GetAttributesQueryParameters(
        page: page,
        limit: limit,
        name: search.value,
      ),
    )
        .then(
      (value) {
        _isLoading.value = false;
        firstLoading = false;
        if (!value.error) {
          _attributes.value = value.data['docs']
              .map<AttributeModel>((e) => AttributeModel.fromMap(e))
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
      attributeRepository
          .getAttributes(
        GetAttributesQueryParameters(
          page: page,
          limit: limit,
          name: search.value,
        ),
      )
          .then(
        (value) {
          loadMoreLoading = false;
          if (!value.error) {
            var n = value.data['docs']
                .map<AttributeModel>((e) => AttributeModel.fromMap(e))
                .toList();
            _attributes.value = [..._attributes.value, ...n];

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
    getAttributes();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteAttribute() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Attribute',
        middleText: 'Are you sure you want to delete this attribute?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          attributeRepository
              .deleteAttribute(
            DeleteAttributeParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Attribute deleted successfully',
                  type: SnackType.success,
                );
                getAttributes();
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
