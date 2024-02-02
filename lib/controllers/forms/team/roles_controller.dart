// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/team/roles_repository.dart';
import 'package:invoder_app/data/repositories/team/roles_parameters.dart';
import 'package:invoder_app/data/repositories/data_repository.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/team_models.dart';

class RolesController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  RoleRepository roleRepository = Get.put(RoleRepository());
  DataRepository dataRepository = Get.put(DataRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final RxList<String> _permissions = <String>[].obs;
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  final RxList<Map<String, dynamic>> _permissionsList =
      <Map<String, dynamic>>[].obs;
  final RxList<RoleModel> _roles = <RoleModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  List<RoleModel> get roles => _roles.value;
  int get page => _page.value;
  int get limit => _limit.value;
  bool get nextPage => _nextPage.value;
  bool get selectable => _selectable.value;
  List<String> get selected => _selected.value;
  bool get firstLoading => _firstLoading.value;
  bool get loadMoreLoading => _loadMoreLoading.value;
  ScrollController get scrollController => _scrollController;
  List<String> get permissions => _permissions;
  List<Map<String, dynamic>> get permissionsList => _permissionsList;

  set buttonDisabled(value) => _buttonDisabled.value = value;
  set isLoading(value) => _isLoading.value = value;
  set permissionsList(value) => _permissionsList.value = value;
  set setRoles(value) => _roles.value = value;
  set page(value) => _page.value = value;
  set limit(value) => _limit.value = value;
  set nextPage(value) => _nextPage.value = value;
  set search(value) => search.value = value;
  set selectable(value) => _selectable.value = value;
  set selected(value) => _selected.value = value;
  set firstLoading(value) => _firstLoading.value = value;
  set loadMoreLoading(value) => _loadMoreLoading.value = value;
  set permissions(List<String> value) => _permissions.value = value;

  bool get isLoading => _isLoading.value;
  bool get buttonDisabled => _buttonDisabled.value;

  void editRole(id, name, p) {
    editId.value = id;
    nameController.text = name;
    permissions = p;
  }

  void reset() {
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _roles.value = [];
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
    permissions = [];
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  void updateRole() {
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      roleRepository
          .updateRole(
        editId.value,
        UpdateRoleParameters(
          name: nameController.text,
          permissions: permissions,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Role updated successfully',
              type: SnackType.success,
            );
            getRoles();
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

  void createRole() {
    if (editId.isNotEmpty) {
      updateRole();
      return;
    }
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      roleRepository
          .createRole(
        CreateRoleParameters(
          name: nameController.text,
          permissions: permissions,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Role created successfully',
              type: SnackType.success,
            );
            editId.value = value.data['id'];
            getRoles();
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

  void getRoles() {
    _isLoading.value = true;
    roleRepository
        .getRoles(
      GetRolesQueryParameters(
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
          _roles.value = value.data['docs']
              .map<RoleModel>((e) => RoleModel.fromMap(e))
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
      roleRepository
          .getRoles(
        GetRolesQueryParameters(
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
                .map<RoleModel>((e) => RoleModel.fromMap(e))
                .toList();
            _roles.value = [..._roles.value, ...n];

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

  void getPermissions() {
    dataRepository
        .getData(
      'permissions',
    )
        .then(
      (value) {
        if (!value.error) {
          permissionsList = value.data.map<Map<String, dynamic>>(
            (e) {
              return {
                'label': e['label'],
                'value': e['key'],
                'description': e['description'] ?? '',
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
    getRoles();
    getPermissions();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteRole() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Role',
        middleText: 'Are you sure you want to delete this role?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          roleRepository
              .deleteRole(
            DeleteRoleParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Role deleted successfully',
                  type: SnackType.success,
                );
                getRoles();
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
