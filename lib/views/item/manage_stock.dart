import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/stock_controller.dart';

class ManageStockScreen extends StatefulWidget {
  final int stock;
  final String itemId;
  final String? variationId;
  final Function(int e) onStockUpdated;
  const ManageStockScreen(
      {Key? key,
      required this.itemId,
      required this.onStockUpdated,
      this.variationId,
      this.stock = 0})
      : super(key: key);

  @override
  State<ManageStockScreen> createState() => _ManageStockScreenState();
}

class _ManageStockScreenState extends State<ManageStockScreen> {
  final StocksController stocksController = Get.put(StocksController());

  @override
  void initState() {
    stocksController.init();
    stocksController.itemId.value = widget.itemId;
    if (widget.variationId != null) {
      stocksController.variationId.value = widget.variationId!;
    }
    stocksController.onStockUpdated = widget.onStockUpdated;
    super.initState();
  }

  @override
  void dispose() {
    stocksController.resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Manage Stock',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ThemeColors.borderColor,
                      ),
                    ),
                    child: Form(
                      key: stocksController.formKey,
                      child: Column(
                        children: [
                          Obx(
                            () => CustomSelectField(
                              label: 'Reasone',
                              onChanged: (s) {
                                stocksController.reason = s;
                              },
                              value: stocksController.reason,
                              hasBorder: false,
                              items: stocksController.reasons,
                            ),
                          ),
                          CustomTextField(
                            placeholder: '0',
                            prefix: const Text('Value',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            type: CustomTextFieldType.number,
                            hasBorder: false,
                            textAlign: TextAlign.right,
                            controller: stocksController.valueController,
                            validator: stocksController.validateValue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Current Stock:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.stock.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
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
                  stocksController.updateStock();
                },
                loading: stocksController.isLoading,
                disabled: stocksController.buttonDisabled ||
                    stocksController.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
