// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/item/unit/unit_repository.dart';
import 'package:invoder_app/data/repositories/item/unit/unit_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/item_models.dart';

class UnitsController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  UnitRepository unitRepository = Get.put(UnitRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final shortNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  final RxList<UnitModel> _units = <UnitModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  List<UnitModel> get units => _units.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;

  set setUnits(value) => _units.value = value;
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
  void setShortName(String value) => shortNameController.text = value;
  void setDescription(String value) => descriptionController.text = value;

  void editUnit(id, name, shortName, description) {
    editId.value = id;
    nameController.text = name;
    shortNameController.text = shortName;
    descriptionController.text = description;
  }

  void reset() {
    nameController.text = '';
    shortNameController.text = '';
    descriptionController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _units.value = [];
    _page.value = 1;
    _limit.value = 20;
    _nextPage.value = false;
    search.value = '';
    _firstLoading.value = true;
    _scrollController.dispose();
  }

  void resetForm() {
    nameController.text = '';
    shortNameController.text = '';
    descriptionController.text = '';
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

  String? validateShortName(String? value) {
    if (value!.isEmpty) {
      return 'Short Name is required';
    }
    return null;
  }

  void createUnit() {
    if (editId.value.isNotEmpty) {
      updateUnit();
    } else if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      unitRepository
          .createUnit(
        CreateUnitParameters(
          name: nameController.text,
          shortName: shortNameController.text,
          description: descriptionController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (!value.error) {
            editId.value = value.data['id'];
            Snackbar.show(
              message: 'Unit created successfully',
              type: SnackType.success,
            );
            getUnits();
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

  void updateUnit() {
    if (formKey.currentState!.validate() && editId.value.isNotEmpty) {
      _isLoading.value = true;
      unitRepository
          .updateUnit(
        UpdateUnitParameters(
          name: nameController.text,
          shortName: shortNameController.text,
          description: descriptionController.text,
        ),
        editId.value,
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Unit updated successfully',
              type: SnackType.success,
            );
            getUnits();
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

  void getUnits() {
    _isLoading.value = true;
    unitRepository
        .getUnits(
      GetUnitsQueryParameters(
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
          _units.value = value.data['docs']
              .map<UnitModel>((e) => UnitModel.fromMap(e))
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
      unitRepository
          .getUnits(
        GetUnitsQueryParameters(
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
                .map<UnitModel>((e) => UnitModel.fromMap(e))
                .toList();
            _units.value = [..._units.value, ...n];

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
    getUnits();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteUnit() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Unit',
        middleText: 'Are you sure you want to delete this unit?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          unitRepository
              .deleteUnit(
            DeleteUnitParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Unit deleted successfully',
                  type: SnackType.success,
                );
                getUnits();
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
