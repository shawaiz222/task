import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:invoder_app/components/item_components/index.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import './manage_stock.dart';
import 'package:invoder_app/controllers/forms/item/products_controller.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/variation_controller.dart';

class EditVariationScreen extends StatefulWidget {
  final String itemId;
  final Map<String, dynamic> variation;
  const EditVariationScreen(
      {Key? key, required this.itemId, required this.variation})
      : super(key: key);

  @override
  State<EditVariationScreen> createState() => _EditVariationScreenState();
}

class _EditVariationScreenState extends State<EditVariationScreen> {
  final VariationController _variationController =
      Get.put(VariationController());
  final ProductsController productsController = Get.put(ProductsController());

  @override
  void initState() {
    super.initState();
    _variationController.itemId = widget.itemId;
    _variationController.editVariation(widget.variation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Obx(
          () => Text(
            _variationController.editId.isEmpty
                ? 'Add Variation'
                : 'Edit Variation',
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
                  key: _variationController.formKey,
                  child: Column(
                    children: [
                      Obx(
                        () => CustomImagePicker(
                          onImageSelected: (image) {
                            _variationController.image = image;
                          },
                          value: _variationController.image,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Name',
                        placeholder: 'Enter Name',
                        controller: _variationController.nameController,
                        isReadOnly: _variationController.isProductVariation,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price and stock',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
                                    _variationController.priceController,
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
                                controller: _variationController.skuController,
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
                                controller:
                                    _variationController.barcodeController,
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
                                  value: _variationController.stock,
                                  onTap: () {
                                    if (_variationController
                                        .editId.isNotEmpty) {
                                      Get.to(
                                        () => ManageStockScreen(
                                          stock: _variationController.stock,
                                          itemId: _variationController.itemId,
                                          variationId:
                                              _variationController.editId,
                                          onStockUpdated: _variationController
                                              .onStockUpdated,
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: ThemeColors.grayColor,
                                      fontSize: 10,
                                    ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Delete Variation',
                            onPressed: () {
                              _variationController.deleteVariation();
                            },
                            size: CustomButtonSize.small,
                            variant: CustomButtonVariant.danger,
                          ),
                        ],
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
                loading: _variationController.isLoading,
                disabled: _variationController.buttonDisabled,
                text: 'Save',
                onPressed: () {
                  _variationController.updateVariation();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
