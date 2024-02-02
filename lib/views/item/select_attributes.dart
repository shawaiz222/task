import 'package:flutter/material.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/products_controller.dart';

class SelectAttributesScreen extends StatefulWidget {
  const SelectAttributesScreen({Key? key}) : super(key: key);

  @override
  State<SelectAttributesScreen> createState() => _SelectAttributesScreenState();
}

class _SelectAttributesScreenState extends State<SelectAttributesScreen> {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  void dispose() {
    super.dispose();
    productsController.updateAttributes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Select Attributes',
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(Get.context!).size.height * 0.8,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please select attributes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'You need to select attributes before adding variations',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: productsController.attributes.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  productsController.attributes[index]['label'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Checkbox(
                                  value: productsController.productAttributes
                                      .contains(
                                    productsController.attributes[index]
                                        ['value'],
                                  ),
                                  onChanged: (value) {
                                    if (value == true) {
                                      productsController.productAttributes = [
                                        ...productsController.productAttributes,
                                        productsController.attributes[index]
                                            ['value'],
                                      ];
                                    } else {
                                      var list = productsController
                                          .productAttributes
                                          .toList();
                                      list.removeWhere((element) =>
                                          element ==
                                          productsController.attributes[index]
                                              ['value']);
                                      productsController.productAttributes =
                                          list;
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
