import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';

enum CustomSelectFieldVariant {
  defaultLabel,
  lableOutside,
}

class CustomSelectField extends StatelessWidget {
  final String label;
  final dynamic value;
  final String? placeholder;
  final List<Map<String, dynamic>> items;
  final Function(dynamic) onChanged;
  final bool isMultiple;
  final CustomSelectFieldVariant variant;
  final String? error;
  final bool bottomBorder;
  final bool borderRadiusTop;
  final bool hasBorder;
  final Widget? customHeaderAction;

  const CustomSelectField({
    Key? key,
    required this.label,
    this.placeholder,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMultiple = false,
    this.variant = CustomSelectFieldVariant.defaultLabel,
    this.error,
    this.borderRadiusTop = true,
    this.bottomBorder = true,
    this.hasBorder = true,
    this.customHeaderAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Choice.prompt(
      multiple: isMultiple,
      onChanged: (state) => {
        if (state.isNotEmpty)
          {
            if (isMultiple)
              {onChanged(state.map((e) => e['value']).toList())}
            else
              {onChanged(state[0]['value'])}
          }
      },
      itemCount: items.length,
      title: label,
      itemBuilder: (state, i) {
        return Container(
          color: Colors.white,
          height: 50,
          child: isMultiple
              ? CheckboxListTile(
                  title: Text(items[i]['label'] ?? ''),
                  value: state.selected(items[i]),
                  onChanged: state.onSelected(items[i]))
              : RadioListTile(
                  title: Text(items[i]['label'] ?? ''),
                  value: items[i],
                  groupValue: state.single,
                  onChanged: (value) {
                    state.select(items[i]);
                  },
                ),
        );
      },
      listBuilder: ChoiceList.createVirtualized(),
      value: value.isNotEmpty
          ? isMultiple
              ? [...value.map((e) => items.firstWhere((i) => i['value'] == e))]
              : [items.firstWhere((e) => e['value'] == value)]
          : [],
      modalHeaderBuilder: ChoiceModal.createHeader(
        title: Text(label),
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
        actionsBuilder: [
          if (isMultiple)
            (state) {
              final values = items;
              return Checkbox(
                value: state.selectedMany(values),
                onChanged: state.onSelectedMany(values),
                tristate: true,
              );
            },
          ChoiceModal.createSpacer(width: 20),
          if (customHeaderAction != null) (state) => customHeaderAction!,
        ],
      ),
      promptDelegate: ChoicePrompt.delegateBottomSheet(
          maxHeightFactor: (.06 * items.length) + .08,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              // bottomLeft: Radius.circular(16),
              // bottomRight: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.white),
      searchable: true,
      itemSkip: (state, i) =>
          !ChoiceSearch.match(items[i]['label'], state.search?.value),
      anchorBuilder: (state, prompt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (variant == CustomSelectFieldVariant.lableOutside)
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (variant == CustomSelectFieldVariant.lableOutside)
              const SizedBox(height: 4),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => prompt(),
              child: Container(
                height: 48,
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 14),
                decoration: BoxDecoration(
                  border: hasBorder
                      ? bottomBorder
                          ? Border.all(
                              color: error != null
                                  ? ThemeColors.redColor
                                  : ThemeColors.borderColor)
                          : const Border(
                              bottom: BorderSide(
                                  width: 1, color: ThemeColors.borderColor),
                              top: BorderSide(
                                  width: 1, color: ThemeColors.borderColor),
                              left: BorderSide(
                                  width: 1, color: ThemeColors.borderColor),
                              right: BorderSide(
                                  width: 1, color: ThemeColors.borderColor),
                            )
                      : const Border(
                          bottom: BorderSide(
                              width: 1, color: ThemeColors.borderColor),
                          top: BorderSide(
                              width: 0, color: ThemeColors.borderColor),
                          left: BorderSide(
                              width: 0, color: ThemeColors.borderColor),
                          right: BorderSide(
                              width: 0, color: ThemeColors.borderColor),
                        ),
                  borderRadius: hasBorder
                      ? bottomBorder
                          ? borderRadiusTop
                              ? BorderRadius.circular(8)
                              : const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )
                          : borderRadiusTop
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                )
                              : null
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (variant == CustomSelectFieldVariant.defaultLabel)
                      Text(
                        label,
                        style: TextStyle(
                            color: primaryColor.shade900,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    if (variant == CustomSelectFieldVariant.defaultLabel)
                      const SizedBox(width: 30),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.value.isNotEmpty
                                  ? state.value.length > 1
                                      ? state.value[0]['label'] +
                                          'and ${state.value.length - 1} more'
                                      : state.value[0]['label'] ?? ''
                                  : placeholder ?? 'None',
                              style: TextStyle(
                                  color: state.value.isNotEmpty
                                      ? Colors.black
                                      : ThemeColors.grayColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400),
                              textAlign: variant ==
                                      CustomSelectFieldVariant.lableOutside
                                  ? TextAlign.start
                                  : TextAlign.end,
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (variant == CustomSelectFieldVariant.defaultLabel)
                            CustomIcon(
                              icon: CustomIcons.arrowRightIcon,
                              size: 11,
                              color: ThemeColors.grayColor,
                            ),
                        ],
                      ),
                    ),
                    if (variant == CustomSelectFieldVariant.lableOutside)
                      const Icon(Icons.expand_more_rounded,
                          color: ThemeColors.grayColor, size: 20),
                  ],
                ),
              ),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  error!,
                  style: const TextStyle(
                    color: ThemeColors.redColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
