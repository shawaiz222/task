// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/team/members_repository.dart';
import 'package:invoder_app/data/repositories/team/members_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/team_models.dart';

class MembersController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage();
  MemberRepository memberRepository = Get.put(MemberRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> typeFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final RxString _role = ''.obs;
  final editId = ''.obs;
  final _isLoading = false.obs;
  final _buttonDisabled = false.obs;
  final _selectable = false.obs;
  final _selected = <String>[].obs;
  final _firstLoading = true.obs;
  final _loadMoreLoading = false.obs;

  final RxList<Map<String, dynamic>> _roles = <Map<String, dynamic>>[].obs;
  final RxList<MemberModel> _members = <MemberModel>[].obs;
  final _page = 1.obs;
  final _limit = 10.obs;
  final _nextPage = false.obs;
  final search = ''.obs;
  final searchController = TextEditingController();

  String get role => _role.value;
  List<Map<String, dynamic>> get roles => _roles.value;
  List<MemberModel> get members => _members.value;
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
  set role(value) => _role.value = value;
  set roles(value) => _roles.value = value;
  set setMembers(value) => _members.value = value;
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

  void editMember(id, name, email, phone, r) {
    editId.value = id;
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    role = r;
  }

  void reset() {
    formKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    _members.value = [];
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
    role = '';
  }

  void resetTypeForm() {
    typeFormKey = GlobalKey<FormState>();
    _isLoading.value = false;
    _buttonDisabled.value = false;
    nameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    role = '';
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return 'Phone is required';
    }
    return null;
  }

  String? validateRole(String? value) {
    if (value!.isEmpty) {
      return 'Role is required';
    }
    return null;
  }

  void updateMember() {
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      memberRepository
          .updateMember(
        editId.value,
        UpdateMemberParameters(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          role: role,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Snackbar.show(
              message: 'Member updated successfully',
              type: SnackType.success,
            );
            getMembers();
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

  void createMember() {
    if (editId.isNotEmpty) {
      updateMember();
      return;
    }
    if (formKey.currentState!.validate()) {
      _buttonDisabled.value = true;
      _isLoading.value = true;
      memberRepository
          .createMember(
        CreateMemberParameters(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          role: role,
        ),
      )
          .then(
        (value) {
          _isLoading.value = false;
          _buttonDisabled.value = false;
          if (!value.error) {
            Get.back();
            Snackbar.show(
              message: 'Member created successfully',
              type: SnackType.success,
            );
            editId.value = value.data['id'];
            getMembers();
            // Get.back();
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

  void getMembers() {
    _isLoading.value = true;
    memberRepository
        .getMembers(
      GetMembersQueryParameters(
        page: page,
        limit: limit,
      ),
    )
        .then(
      (value) {
        _isLoading.value = false;
        _firstLoading.value = false;
        if (!value.error) {
          _members.value = value.data['docs']
              .map<MemberModel>((e) => MemberModel.fromMap(e))
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
      memberRepository
          .getMembers(
        GetMembersQueryParameters(
          page: page,
          limit: limit,
        ),
      )
          .then(
        (value) {
          loadMoreLoading = false;
          if (!value.error) {
            var n = value.data['docs']
                .map<MemberModel>((e) => MemberModel.fromMap(e))
                .toList();
            _members.value = [..._members.value, ...n];

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

  void getRoleOptions() {
    memberRepository.getRolesOptions().then(
      (value) {
        if (!value.error) {
          roles = value.data.map<Map<String, dynamic>>(
            (e) {
              return {
                'label': e['label'],
                'value': e['value'],
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
    getRoleOptions();
    getMembers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  void deleteMember() {
    if (selected.isNotEmpty) {
      Get.defaultDialog(
        title: 'Delete Member',
        middleText: 'Are you sure you want to delete this member?',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        backgroundColor: Colors.white,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _isLoading.value = true;
          memberRepository
              .deleteMember(
            DeleteMemberParameters(
              ids: selected,
            ),
          )
              .then(
            (value) {
              _isLoading.value = false;
              if (!value.error) {
                Get.back();
                Snackbar.show(
                  message: 'Member deleted successfully',
                  type: SnackType.success,
                );
                getMembers();
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
