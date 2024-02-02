import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/expenses_controller.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  void initState() {
    super.initState();
    expensesController.init();
  }

  @override
  void dispose() {
    expensesController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Expenses',
      ),
      body: Column(
        children: [
          Obx(
            () => CustomTextField(
              placeholder: 'Search expenses',
              hasBorder: false,
              onFieldSubmitted: (value) {
                expensesController.page = 1;
                expensesController.getExpenses();
              },
              onChanged: (value) {
                expensesController.search(value);
              },
              controller: expensesController.searchController,
              prefix: CustomIcon(
                icon: CustomIcons.searchIcon,
                size: 18,
                color: primaryColor.shade900,
              ),
              suffix: expensesController.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : expensesController.search.value.isNotEmpty
                      ? InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            expensesController.page = 1;
                            expensesController.search('');
                            expensesController.searchController.clear();
                            expensesController.getExpenses();
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
          Obx(() => expensesController.firstLoading
              ? const Expanded(
                  child: ContentLoader(),
                )
              : const SizedBox()),
          Obx(() => (expensesController.expenses.isEmpty &&
                  !expensesController.isLoading)
              ? const Expanded(
                  child: NoData(),
                )
              : const SizedBox()),
          Obx(() => expensesController.expenses.isNotEmpty &&
                  !expensesController.firstLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    controller: expensesController.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: expensesController.expenses.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  key: ValueKey(
                                      expensesController.expenses[index].id),
                                  () => ItemBox(
                                    key: ValueKey(
                                        expensesController.expenses[index].id),
                                    onTap: (id) {
                                      expensesController.editExpense(
                                        id,
                                        expensesController
                                            .expenses[index].type.id,
                                        expensesController
                                            .expenses[index].amount,
                                        expensesController.expenses[index].date,
                                        expensesController
                                            .expenses[index].description,
                                      );
                                      Get.toNamed('/add-expense');
                                    },
                                    name: expensesController
                                        .expenses[index].type.name,
                                    id: expensesController.expenses[index].id,
                                    selectable: expensesController.selectable,
                                    selected: expensesController.selected,
                                    price: expensesController
                                        .expenses[index].amount,
                                    onLongPress: (id) {
                                      expensesController.selectable = true;
                                      expensesController.selected = [id];
                                    },
                                    onSelect: (id) {
                                      if (expensesController.selected
                                          .contains(id)) {
                                        expensesController.selected = [
                                          ...expensesController.selected
                                              .where((element) => element != id)
                                        ];
                                      } else {
                                        expensesController.selected = [
                                          ...expensesController.selected,
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
                          () => expensesController.loadMoreLoading
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
                        Obx(() => !expensesController.loadMoreLoading &&
                                expensesController.nextPage
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    expensesController.loadMore();
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
        () => expensesController.selectable
            ? DeleteActionButton(
                onPressed: () {
                  expensesController.deleteExpense();
                },
                onCanceled: () {
                  expensesController.selectable = false;
                  expensesController.selected = List<String>.empty();
                },
              )
            : SizedBox(
                width: 125,
                height: 33,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/add-expense');
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
                        'Add Expense',
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
