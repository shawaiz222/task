import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:invoder_app/controllers/forms/item/products_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  void initState() {
    super.initState();
    productsController.init();
  }

  @override
  void dispose() {
    productsController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Products',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search products',
              hasBorder: false,
              onFieldSubmitted: (value) {
                productsController.page = 1;
                productsController.getProducts();
              },
              onChanged: (value) {
                productsController.search(value);
              },
              controller: productsController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: productsController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : productsController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            productsController.page = 1;
                            productsController.search('');
                            productsController.searchController.clear();
                            productsController.getProducts();
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
          Expanded(
            child: SingleChildScrollView(
              controller: productsController.scrollController,
              padding: const EdgeInsets.only(bottom: 50),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Obx(() => productsController.firstLoading
                      ? const ContentLoader()
                      : const SizedBox()),
                  Obx(() => (productsController.products.isEmpty &&
                          !productsController.isLoading)
                      ? const NoData()
                      : const SizedBox()),
                  Obx(
                    () {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productsController.products.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            key:
                                ValueKey(productsController.products[index].id),
                            () => ItemBox(
                              key: ValueKey(
                                  productsController.products[index].id),
                              onTap: (id) {
                                productsController.editProduct(
                                    productsController.products[index].id);
                                Get.toNamed('/add-product');
                              },
                              name: productsController.products[index].name,
                              id: productsController.products[index].id,
                              selectable: productsController.selectable,
                              selected: productsController.selected,
                              onLongPress: (id) {
                                productsController.selectable = true;
                                productsController.selected = [id];
                              },
                              onSelect: (id) {
                                if (productsController.selected.contains(id)) {
                                  productsController.selected = [
                                    ...productsController.selected
                                        .where((element) => element != id)
                                  ];
                                } else {
                                  productsController.selected = [
                                    ...productsController.selected,
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
                    () => productsController.loadMoreLoading
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
                  Obx(() => !productsController.loadMoreLoading &&
                          productsController.nextPage
                      ? Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              productsController.loadMore();
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
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(
        () => productsController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  productsController.deleteProduct();
                },
                onCanceled: () {
                  productsController.selectable = false;
                  productsController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-product');
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
                        'Add Product',
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
