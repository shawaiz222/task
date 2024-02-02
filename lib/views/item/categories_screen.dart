import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/categories_controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  void initState() {
    super.initState();
    categoriesController.init();
  }

  @override
  void dispose() {
    categoriesController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Categories',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search categories',
              hasBorder: false,
              onFieldSubmitted: (value) {
                categoriesController.page = 1;
                categoriesController.getCategories();
              },
              onChanged: (value) {
                categoriesController.search(value);
              },
              controller: categoriesController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: categoriesController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : categoriesController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            categoriesController.page = 1;
                            categoriesController.search('');
                            categoriesController.searchController.clear();
                            categoriesController.getCategories();
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
          Obx(() => categoriesController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() => (categoriesController.categories.isEmpty &&
                  !categoriesController.isLoading)
              ? const Expanded(
                  child: NoData(),
                )
              : const SizedBox()),
          Obx(
            () => categoriesController.categories.isNotEmpty &&
                    !categoriesController.firstLoading
                ? Expanded(
                    child: SingleChildScrollView(
                      controller: categoriesController.scrollController,
                      padding: const EdgeInsets.only(bottom: 50),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Obx(
                            () {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    categoriesController.categories.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    key: ValueKey(categoriesController
                                        .categories[index].id),
                                    () => ItemBox(
                                      key: ValueKey(categoriesController
                                          .categories[index].id),
                                      onTap: (id) {
                                        categoriesController.editCategory(
                                          categoriesController
                                              .categories[index].id,
                                          categoriesController
                                              .categories[index].name,
                                          categoriesController
                                              .categories[index].description,
                                        );
                                        Get.toNamed('/add-category');
                                      },
                                      name: categoriesController
                                          .categories[index].name,
                                      id: categoriesController
                                          .categories[index].id,
                                      selectable:
                                          categoriesController.selectable,
                                      selected: categoriesController.selected,
                                      onLongPress: (id) {
                                        categoriesController.selectable = true;
                                        categoriesController.selected = [id];
                                      },
                                      onSelect: (id) {
                                        if (categoriesController.selected
                                            .contains(id)) {
                                          categoriesController.selected = [
                                            ...categoriesController.selected
                                                .where(
                                                    (element) => element != id)
                                          ];
                                        } else {
                                          categoriesController.selected = [
                                            ...categoriesController.selected,
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
                            () => categoriesController.loadMoreLoading
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
                          Obx(() => !categoriesController.loadMoreLoading &&
                                  categoriesController.nextPage
                              ? Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      categoriesController.loadMore();
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
                : const SizedBox(),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => categoriesController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  categoriesController.deleteCategory();
                },
                onCanceled: () {
                  categoriesController.selectable = false;
                  categoriesController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-category');
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
                        'Add Category',
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
