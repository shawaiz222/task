import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/team/members_controller.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final MembersController membersController = Get.put(MembersController());

  @override
  void initState() {
    super.initState();
    membersController.init();
  }

  @override
  void dispose() {
    membersController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Members',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search members',
              hasBorder: false,
              onFieldSubmitted: (value) {
                membersController.page = 1;
                membersController.getMembers();
              },
              onChanged: (value) {
                membersController.search(value);
              },
              controller: membersController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: membersController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : membersController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            membersController.page = 1;
                            membersController.search('');
                            membersController.searchController.clear();
                            membersController.getMembers();
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
          Obx(() => membersController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() => (membersController.members.isEmpty &&
                  !membersController.isLoading)
              ? const Expanded(
                  child: NoData(),
                )
              : const SizedBox()),
          Obx(() => membersController.members.isNotEmpty &&
                  !membersController.firstLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    controller: membersController.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: membersController.members.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  key: ValueKey(
                                      membersController.members[index].id),
                                  () => ItemBox(
                                    key: ValueKey(
                                        membersController.members[index].id),
                                    onTap: (id) {
                                      membersController.editMember(
                                        membersController.members[index].id,
                                        membersController.members[index].name,
                                        membersController
                                                .members[index].email ??
                                            '',
                                        membersController
                                                .members[index].phone ??
                                            '',
                                        membersController.members[index].role ??
                                            '',
                                      );
                                      Get.toNamed('/add-member');
                                    },
                                    name: membersController.members[index].name,
                                    id: membersController.members[index].id,
                                    selectable: membersController.selectable,
                                    selected: membersController.selected,
                                    onLongPress: (id) {
                                      membersController.selectable = true;
                                      membersController.selected = [id];
                                    },
                                    onSelect: (id) {
                                      if (membersController.selected
                                          .contains(id)) {
                                        membersController.selected = [
                                          ...membersController.selected
                                              .where((element) => element != id)
                                        ];
                                      } else {
                                        membersController.selected = [
                                          ...membersController.selected,
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
                          () => membersController.loadMoreLoading
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
                        Obx(() => !membersController.loadMoreLoading &&
                                membersController.nextPage
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    membersController.loadMore();
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
        () => membersController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  membersController.deleteMember();
                },
                onCanceled: () {
                  membersController.selectable = false;
                  membersController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-member');
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
                        'Add Member',
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
