import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/controllers/forms/team/roles_controller.dart';
import 'package:get/get.dart';

class AddRoleScreen extends StatefulWidget {
  const AddRoleScreen({Key? key}) : super(key: key);

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  final RolesController rolesController = Get.put(RolesController());

  @override
  void dispose() {
    rolesController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            rolesController.editId.value.isEmpty ? 'Add Role' : 'Edit Role',
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
                key: rolesController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Name',
                      controller: rolesController.nameController,
                      validator: rolesController.validateName,
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: rolesController.permissionsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    rolesController.permissionsList[index]
                                        ['label'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Checkbox(
                                    value: rolesController.permissions.contains(
                                      rolesController.permissionsList[index]
                                          ['value'],
                                    ),
                                    onChanged: (value) {
                                      if (value == true) {
                                        rolesController.permissions = [
                                          ...rolesController.permissions,
                                          rolesController.permissionsList[index]
                                              ['value'],
                                        ];
                                      } else {
                                        var list = rolesController.permissions
                                            .toList();
                                        list.removeWhere((element) =>
                                            element ==
                                            rolesController
                                                    .permissionsList[index]
                                                ['value']);
                                        rolesController.permissions = list;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                text: rolesController.editId.value.isEmpty ? 'Create' : 'Save',
                onPressed: () {
                  rolesController.createRole();
                },
                loading: rolesController.isLoading,
                disabled:
                    rolesController.buttonDisabled || rolesController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
