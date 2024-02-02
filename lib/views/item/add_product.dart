import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import './manage_stock.dart';
import './edit_variation.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/products_controller.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  void initState() {
    super.initState();
    if (productsController.editId.value.isEmpty) {
      productsController.createProduct();
    } else {
      productsController.buttonDisabled = false;
    }
  }

  @override
  void dispose() {
    productsController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            productsController.editId.value.isEmpty
                ? 'Add Product'
                : 'Edit Product',
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
            child: ScrollShadow(
              color: ThemeColors.lightGrayColor,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: productsController.formKey,
                  child: Column(
                    children: [
                      Obx(
                        () => CustomImagePicker(
                          onImageSelected: (image) {
                            productsController.image = image;
                          },
                          value: productsController.image,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Name',
                        placeholder: 'Enter Name',
                        controller: productsController.nameController,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          CustomSelectField(
                            label: 'Category',
                            onChanged: (s) {
                              productsController.category = s;
                            },
                            value: productsController.category,
                            bottomBorder: false,
                            items: productsController.categories,
                          ),
                          CustomSelectField(
                            label: 'Unit',
                            onChanged: (s) {
                              productsController.unit = s;
                            },
                            placeholder: 'Per Item',
                            value: productsController.unit,
                            bottomBorder: false,
                            borderRadiusTop: false,
                            items: productsController.units,
                          ),
                          Obx(() {
                            return CustomSelectField(
                              label: 'Product Type',
                              onChanged: (s) {
                                productsController.type = s;
                              },
                              placeholder: 'Simple Product',
                              value: productsController.type,
                              borderRadiusTop: false,
                              items: productsController.types,
                            );
                          })
                        ],
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => productsController.type == 'simple'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price and stock',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                  ),
                                  const SizedBox(height: 7),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ThemeColors.borderColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(children: [
                                      CustomTextField(
                                        controller:
                                            productsController.priceController,
                                        hasBorder: false,
                                        placeholder: '0.00',
                                        prefix: const Text('Price',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        suffix: const Text('\$'),
                                        type: CustomTextFieldType.number,
                                        textAlign: TextAlign.right,
                                      ),
                                      CustomTextField(
                                        controller:
                                            productsController.skuController,
                                        hasBorder: false,
                                        prefix: const Text('SKU',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        placeholder: '123456',
                                        type: CustomTextFieldType.number,
                                        textAlign: TextAlign.right,
                                      ),
                                      CustomTextField(
                                        controller: productsController
                                            .barcodeController,
                                        hasBorder: false,
                                        prefix: const Text('Barcode',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        placeholder: '01234567689',
                                        type: CustomTextFieldType.number,
                                        textAlign: TextAlign.right,
                                      ),
                                      Obx(
                                        () => StockBox(
                                          name: 'Stock',
                                          value: productsController.stock,
                                          onTap: () {
                                            if (productsController
                                                .editId.value.isNotEmpty) {
                                              Get.to(
                                                () => ManageStockScreen(
                                                  stock:
                                                      productsController.stock,
                                                  itemId: productsController
                                                      .editId.value,
                                                  onStockUpdated: (int e) {
                                                    productsController
                                                        .getProducts();
                                                    productsController.stock =
                                                        e;
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'SKU is a unique id for every single product so its easier to identify and track the inventory (e.g. EF-10002)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: ThemeColors.grayColor,
                                          fontSize: 10,
                                        ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Variations',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                  ),
                                  const SizedBox(height: 7),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ThemeColors.borderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Obx(
                                      () => ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: productsController
                                            .productVariations.length,
                                        itemBuilder: (context, index) {
                                          return VariationBox(
                                            name: generateVariationName(
                                                productsController
                                                    .productVariations[index]),
                                            onTap: () {
                                              Get.to(
                                                () => EditVariationScreen(
                                                  variation: productsController
                                                      .productVariations[index],
                                                  itemId: productsController
                                                      .editId.value,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomButton(
                                    text: 'Add Variations',
                                    onPressed: () {
                                      productsController.addVariation();
                                    },
                                    size: CustomButtonSize.small,
                                    variant: CustomButtonVariant.light,
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 23),
                      Obx(
                        () => CustomSwitch(
                          label: 'Non Taxable Product',
                          value: productsController.nonTaxable,
                          onChanged: (v) {
                            productsController.nonTaxable = v;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: productsController.descriptionController,
                        label: 'Description',
                        placeholder: 'Enter Description',
                        type: CustomTextFieldType.textarea,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 15),
            child: Obx(
              () => CustomButton(
                text: 'Save',
                onPressed: () {
                  productsController.updateProduct();
                },
                loading: productsController.isLoading,
                disabled: productsController.buttonDisabled ||
                    productsController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
