import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/attributes_controller.dart';

class AttributesScreen extends StatefulWidget {
  const AttributesScreen({Key? key}) : super(key: key);

  @override
  State<AttributesScreen> createState() => _AttributesScreenState();
}

class _AttributesScreenState extends State<AttributesScreen> {
  final AttributesController attributesController =
      Get.put(AttributesController());

  @override
  void initState() {
    super.initState();
    attributesController.init();
  }

  @override
  void dispose() {
    attributesController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Attributes',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search attributes',
              hasBorder: false,
              onFieldSubmitted: (value) {
                attributesController.page = 1;
                attributesController.getAttributes();
              },
              onChanged: (value) {
                attributesController.search(value);
              },
              controller: attributesController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: attributesController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : attributesController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            attributesController.page = 1;
                            attributesController.search('');
                            attributesController.searchController.clear();
                            attributesController.getAttributes();
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
          Obx(() => attributesController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() => (attributesController.attributes.isEmpty &&
                  !attributesController.isLoading)
              ? const Expanded(
                  child: NoData(),
                )
              : const SizedBox()),
          Obx(() => attributesController.attributes.isNotEmpty &&
                  !attributesController.firstLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    controller: attributesController.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: attributesController.attributes.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  key: ValueKey(attributesController
                                      .attributes[index].id),
                                  () => ItemBox(
                                    key: ValueKey(attributesController
                                        .attributes[index].id),
                                    onTap: (id) {
                                      attributesController.editAttribute(
                                        attributesController
                                            .attributes[index].id,
                                        attributesController
                                            .attributes[index].name,
                                        attributesController
                                            .attributes[index].displayName,
                                        attributesController
                                            .attributes[index].values,
                                      );
                                      Get.toNamed('/add-attribute');
                                    },
                                    name: attributesController
                                        .attributes[index].name,
                                    id: attributesController
                                        .attributes[index].id,
                                    selectable: attributesController.selectable,
                                    selected: attributesController.selected,
                                    onLongPress: (id) {
                                      attributesController.selectable = true;
                                      attributesController.selected = [id];
                                    },
                                    onSelect: (id) {
                                      if (attributesController.selected
                                          .contains(id)) {
                                        attributesController.selected = [
                                          ...attributesController.selected
                                              .where((element) => element != id)
                                        ];
                                      } else {
                                        attributesController.selected = [
                                          ...attributesController.selected,
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
                          () => attributesController.loadMoreLoading
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
                        Obx(() => !attributesController.loadMoreLoading &&
                                attributesController.nextPage
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    attributesController.loadMore();
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
        () => attributesController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  attributesController.deleteAttribute();
                },
                onCanceled: () {
                  attributesController.selectable = false;
                  attributesController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-attribute');
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
                        'Add Attribute',
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
