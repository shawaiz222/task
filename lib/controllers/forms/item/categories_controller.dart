// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/item/category/categoy_repository.dart';
import 'package:invoder_app/data/repositories/item/category/category_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/item_models.dart';

class CategoriesController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  CategoryRepository categoryRepository = Get.put(CategoryRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  List<CategoryModel> get categories => _categories.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;

  set setCategories(value) => _categories.value = value;
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
  void setDescription(String value) => descriptionController.text = value;

  void editCategory(id, name, description) {
    editId.value = id;
    nameController.text = name;
    descriptionController.text = description;
  }

  void reset() {
    nameController.text = '';
    descriptionController.text = '';
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _categories.value = [];
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
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  void createCategory() {
    if (editId.value.isNotEmpty) {
      updateCategory();
    } else if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      categoryRepository
          .createCategory(
        CreateCategoryParameters(
          name: nameController.text,
          description: descriptionController.text,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (!value.error) {
            editId.value = value.data['id'];
            Snackbar.show(
              message: 'Category created successfully',
              type: SnackType.success,
            );
            getCategories();
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

  void updateCategory() {
    if (formKey.currentState!.validate() && editId.value.isNotEmpty) {
      _isLoading.value = true;
      categoryRepository
          .updateCategory(
        UpdateCategoryParameters(
          name: nameController.text,
          description: descriptionController.text,
        ),
        editId.value,
      )
          .then(
        (value) {
          _isLoading.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Category updated successfully',
              type: SnackType.success,
            );
            getCategories();
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

  void getCategories() {
    _isLoading.value = true;
    categoryRepository
        .getCategories(
      GetCategoriesQueryParameters(
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
          _categories.value = value.data['docs']
              .map<CategoryModel>((e) => CategoryModel.fromMap(e))
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
      categoryRepository
          .getCategories(
        GetCategoriesQueryParameters(
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
                .map<CategoryModel>((e) => CategoryModel.fromMap(e))
                .toList();
            _categories.value = [..._categories.value, ...n];

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
    getCategories();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteCategory() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Category',
        middleText: 'Are you sure you want to delete this category?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          categoryRepository
              .deleteCategory(
            DeleteCategoryParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Category deleted successfully',
                  type: SnackType.success,
                );
                getCategories();
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
