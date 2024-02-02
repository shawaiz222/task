import 'package:flutter/material.dart';
import 'package:invoder_app/components/appbars/default_app_bar.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:get/get.dart';
import 'package:invoder_app/controllers/forms/item/variation_controller.dart';

class SelectVariationScreen extends StatefulWidget {
  final List<String> ids;
  final String itemId;
  const SelectVariationScreen(
      {Key? key, required this.ids, required this.itemId})
      : super(key: key);

  @override
  State<SelectVariationScreen> createState() => _SelectVariationScreenState();
}

class _SelectVariationScreenState extends State<SelectVariationScreen> {
  final VariationController _variationController =
      Get.put(VariationController());

  @override
  void initState() {
    super.initState();
    _variationController.getAttributes(widget.ids);
    _variationController.itemId = widget.itemId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Select Variation',
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Obx(
                () => ListView.builder(
                  itemCount: _variationController.attributesList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Obx(
                          () => CustomSelectField(
                            label: _variationController
                                .attributesList[index].displayName,
                            items: _variationController
                                .attributesList[index].values
                                .map((e) => {
                                      'value': e.id,
                                      'label': e.name,
                                    })
                                .toList(),
                            value: _variationController.variables[index]
                                    ['value'] ??
                                '',
                            onChanged: (value) {
                              _variationController.variables =
                                  _variationController.variables.map((e) {
                                if (e['attribute'] ==
                                    _variationController
                                        .attributesList[index].id) {
                                  e['value'] = value;
                                }
                                return e;
                              }).toList();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 15),
            child: Obx(
              () => CustomButton(
                text: 'Create',
                loading: _variationController.isLoading,
                disabled: _variationController.buttonDisabled,
                onPressed: () {
                  _variationController.createVariation();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
