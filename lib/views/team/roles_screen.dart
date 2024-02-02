import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/team/roles_controller.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({Key? key}) : super(key: key);

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  final RolesController rolesController = Get.put(RolesController());

  @override
  void initState() {
    super.initState();
    rolesController.init();
  }

  @override
  void dispose() {
    rolesController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Roles',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search roles',
              hasBorder: false,
              onFieldSubmitted: (value) {
                rolesController.page = 1;
                rolesController.getRoles();
              },
              onChanged: (value) {
                rolesController.search(value);
              },
              controller: rolesController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: rolesController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : rolesController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            rolesController.page = 1;
                            rolesController.search('');
                            rolesController.searchController.clear();
                            rolesController.getRoles();
                          },
                          child: Icon(
                            Icons.clear,
                            color: primaryColor.shade900,
                            size: 18,
                          ),
                        )
                      : null,
            ),
          ),
          Obx(() => rolesController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() =>
              (rolesController.roles.isEmpty && !rolesController.isLoading)
                  ? const Expanded(
                      child: NoData(),
                    )
                  : const SizedBox()),
          Obx(() => rolesController.roles.isNotEmpty &&
                  !rolesController.firstLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    controller: rolesController.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rolesController.roles.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  key:
                                      ValueKey(rolesController.roles[index].id),
                                  () => ItemBox(
                                    key: ValueKey(
                                        rolesController.roles[index].id),
                                    onTap: (id) {
                                      rolesController.editRole(
                                        rolesController.roles[index].id,
                                        rolesController.roles[index].name,
                                        rolesController
                                            .roles[index].permissions,
                                      );
                                      Get.toNamed('/add-role');
                                    },
                                    name: rolesController.roles[index].name,
                                    id: rolesController.roles[index].id,
                                    selectable: rolesController.selectable,
                                    selected: rolesController.selected,
                                    onLongPress: (id) {
                                      rolesController.selectable = true;
                                      rolesController.selected = [id];
                                    },
                                    onSelect: (id) {
                                      if (rolesController.selected
                                          .contains(id)) {
                                        rolesController.selected = [
                                          ...rolesController.selected
                                              .where((element) => element != id)
                                        ];
                                      } else {
                                        rolesController.selected = [
                                          ...rolesController.selected,
                                          id
                                        ];
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Obx(
                          () => rolesController.loadMoreLoading
                              ? const Column(
                                  children: [
                                    SizedBox(height: 20),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        Obx(() => !rolesController.loadMoreLoading &&
                                rolesController.nextPage
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    rolesController.loadMore();
                                  },
                                  child: const Text('Load More',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            : const SizedBox()),
                      ],
                    ),
                  ),
                )
              : const SizedBox()),
        ],
      ),
      floatingActionButton: Obx(
        () => rolesController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  rolesController.deleteRole();
                },
                onCanceled: () {
                  rolesController.selectable = false;
                  rolesController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-role');
                  },
                  backgroundColor: primaryColor.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIcon(
                        icon: CustomIcons.plusIcon,
                        size: 13,
                        color: ThemeColors.whiteColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Add Role',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ThemeColors.whiteColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
