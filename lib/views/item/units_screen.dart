import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/units_controller.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({Key? key}) : super(key: key);

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  final UnitsController unitsController = Get.put(UnitsController());

  @override
  void initState() {
    super.initState();
    unitsController.init();
  }

  @override
  void dispose() {
    unitsController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Units',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search units',
              hasBorder: false,
              onFieldSubmitted: (value) {
                unitsController.page = 1;
                unitsController.getUnits();
              },
              onChanged: (value) {
                unitsController.search(value);
              },
              controller: unitsController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: unitsController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : unitsController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            unitsController.page = 1;
                            unitsController.search('');
                            unitsController.searchController.clear();
                            unitsController.getUnits();
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
          Obx(() => unitsController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() =>
              (unitsController.units.isEmpty && !unitsController.isLoading)
                  ? const Expanded(
                      child: NoData(),
                    )
                  : const SizedBox()),
          Obx(() => unitsController.units.isNotEmpty &&
                  !unitsController.firstLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    controller: unitsController.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: unitsController.units.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  key:
                                      ValueKey(unitsController.units[index].id),
                                  () => ItemBox(
                                    key: ValueKey(
                                        unitsController.units[index].id),
                                    onTap: (id) {
                                      unitsController.editUnit(
                                        unitsController.units[index].id,
                                        unitsController.units[index].name,
                                        unitsController.units[index].shortName,
                                        unitsController
                                            .units[index].description,
                                      );
                                      Get.toNamed('/add-unit');
                                    },
                                    name: unitsController.units[index].name,
                                    shortName:
                                        unitsController.units[index].shortName,
                                    id: unitsController.units[index].id,
                                    selectable: unitsController.selectable,
                                    selected: unitsController.selected,
                                    onLongPress: (id) {
                                      unitsController.selectable = true;
                                      unitsController.selected = [id];
                                    },
                                    onSelect: (id) {
                                      if (unitsController.selected
                                          .contains(id)) {
                                        unitsController.selected = [
                                          ...unitsController.selected
                                              .where((element) => element != id)
                                        ];
                                      } else {
                                        unitsController.selected = [
                                          ...unitsController.selected,
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
                          () => unitsController.loadMoreLoading
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
                        Obx(() => !unitsController.loadMoreLoading &&
                                unitsController.nextPage
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    unitsController.loadMore();
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
        () => unitsController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  unitsController.deleteUnit();
                },
                onCanceled: () {
                  unitsController.selectable = false;
                  unitsController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-unit');
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
                        'Add Unit',
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
