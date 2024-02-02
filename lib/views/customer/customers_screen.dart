import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/customers_controller.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final CustomersController customersController =
      Get.put(CustomersController());

  @override
  void initState() {
    super.initState();
    customersController.init();
  }

  @override
  void dispose() {
    customersController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Customers',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search customers',
              hasBorder: false,
              onFieldSubmitted: (value) {
                customersController.page = 1;
                customersController.getCustomers();
              },
              onChanged: (value) {
                customersController.search(value);
              },
              controller: customersController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: customersController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : customersController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            customersController.page = 1;
                            customersController.search('');
                            customersController.searchController.clear();
                            customersController.getCustomers();
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
          Obx(() => customersController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() => (customersController.customers.isEmpty &&
                  !customersController.isLoading)
              ? const Expanded(
                  child: NoData(),
                )
              : const SizedBox()),
          Obx(() => customersController.customers.isNotEmpty &&
                  !customersController.firstLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    controller: customersController.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: customersController.customers.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  key: ValueKey(
                                      customersController.customers[index].id),
                                  () => ItemBox(
                                    key: ValueKey(customersController
                                        .customers[index].id),
                                    onTap: (id) {
                                      customersController.editCustomer(
                                        id,
                                        customersController
                                            .customers[index].name,
                                        customersController
                                            .customers[index].email,
                                        customersController
                                            .customers[index].phone,
                                        customersController
                                            .customers[index].address,
                                      );
                                      Get.toNamed('/add-customer');
                                    },
                                    name: customersController
                                        .customers[index].name,
                                    id: customersController.customers[index].id,
                                    selectable: customersController.selectable,
                                    selected: customersController.selected,
                                    onLongPress: (id) {
                                      customersController.selectable = true;
                                      customersController.selected = [id];
                                    },
                                    onSelect: (id) {
                                      if (customersController.selected
                                          .contains(id)) {
                                        customersController.selected = [
                                          ...customersController.selected
                                              .where((element) => element != id)
                                        ];
                                      } else {
                                        customersController.selected = [
                                          ...customersController.selected,
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
                          () => customersController.loadMoreLoading
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
                        Obx(() => !customersController.loadMoreLoading &&
                                customersController.nextPage
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    customersController.loadMore();
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
        () => customersController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  customersController.deleteCustomer();
                },
                onCanceled: () {
                  customersController.selectable = false;
                  customersController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-customer');
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
                        'Add Customer',
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
