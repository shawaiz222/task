// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/controllers/forms/team/members_controller.dart';
import 'package:get/get.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final MembersController membersController = Get.put(MembersController());

  @override
  void dispose() {
    membersController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            membersController.editId.value.isEmpty
                ? 'Add Member'
                : 'Edit Member',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: membersController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      controller: membersController.nameController,
                      validator: membersController.validateName,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Email',
                      controller: membersController.emailController,
                      validator: membersController.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Phone',
                      controller: membersController.phoneController,
                      validator: membersController.validatePhone,
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomSelectField(
                        error: membersController.role == null ||
                                membersController.role.isEmpty
                            ? "Select the Role"
                            : null,
                        label: 'Role',
                        onChanged: (s) {
                          membersController.role = s;
                        },
                        placeholder: 'Select Role',
                        value: membersController.role,
                        items: membersController.roles,
                        variant: CustomSelectFieldVariant.lableOutside,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 15),
            child: Obx(
              () => CustomButton(
                text:
                    membersController.editId.value.isEmpty ? 'Create' : 'Save',
                onPressed: () {
                  membersController.createMember();
                },
                loading: membersController.isLoading,
                disabled: membersController.buttonDisabled ||
                    membersController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
