import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoder_app/utils/colors.dart';

enum CustomTextFieldType {
  text,
  number,
  email,
  password,
  phone,
  textarea,
}

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? Function(String?)? validator;
  final void Function(dynamic)? onChanged;
  final dynamic value;
  final Widget? prefix;
  final CustomTextFieldType type;
  final Widget? suffix;
  final TextAlign textAlign;
  final bool hasBorder;
  final TextEditingController? controller;
  final bool isReadOnly;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
    Key? key,
    this.label,
    this.validator,
    this.onChanged,
    this.value,
    this.placeholder,
    this.prefix,
    this.type = CustomTextFieldType.text,
    this.suffix,
    this.textAlign = TextAlign.start,
    this.hasBorder = true,
    this.controller,
    this.isReadOnly = false,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (widget.label != null) const SizedBox(height: 4),
        TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          readOnly: widget.isReadOnly,
          onChanged: widget.onChanged,
          initialValue: widget.value,
          validator: widget.validator,
          keyboardType: widget.type == CustomTextFieldType.number
              ? TextInputType.number
              : widget.type == CustomTextFieldType.phone
                  ? TextInputType.phone
                  : widget.type == CustomTextFieldType.email
                      ? TextInputType.emailAddress
                      : widget.type == CustomTextFieldType.password
                          ? TextInputType.visiblePassword
                          : widget.type == CustomTextFieldType.textarea
                              ? TextInputType.multiline
                              : TextInputType.text,
          obscureText: widget.type == CustomTextFieldType.password,
          controller: widget.controller,
          inputFormatters: [
            if (widget.type == CustomTextFieldType.number)
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d+\.?\d{0,2}'),
              ),
            if (widget.type == CustomTextFieldType.phone)
              FilteringTextInputFormatter.digitsOnly,
            if (widget.type == CustomTextFieldType.email)
              FilteringTextInputFormatter.singleLineFormatter,
            if (widget.type == CustomTextFieldType.password)
              FilteringTextInputFormatter.singleLineFormatter,
          ],
          maxLines: widget.type == CustomTextFieldType.textarea ? 3 : 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: widget.prefix != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 13, right: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.prefix!,
                      ],
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 48,
            ),
            fillColor: ThemeColors.lightGrayColor,
            filled: widget.isReadOnly,
            suffixIcon: widget.suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.suffix!,
                      ],
                    ),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 48,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            hintText: widget.placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ThemeColors.grayColor,
            ),
            errorStyle: const TextStyle(
              fontSize: 11,
              color: ThemeColors.redColor,
              fontWeight: FontWeight.w500,
              height: 0.1,
            ),
            focusedBorder: widget.hasBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.isReadOnly
                          ? ThemeColors.borderColor
                          : primaryColor.shade500,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.isReadOnly
                          ? ThemeColors.borderColor
                          : primaryColor.shade500,
                      width: 1,
                    ),
                  ),
            contentPadding: widget.prefix != null || widget.suffix != null
                ? GetPlatform.isDesktop
                    ? const EdgeInsets.only(
                        left: 14, right: 14, top: 18, bottom: 8)
                    : const EdgeInsets.only(
                        left: 14, right: 14, top: 14, bottom: 13)
                : const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            border: widget.hasBorder
                ? const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.borderColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.borderColor,
                      width: 1,
                    ),
                  ),
            enabledBorder: widget.hasBorder
                ? const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.borderColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.borderColor,
                      width: 1,
                    ),
                  ),
          ),
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          textAlign: widget.textAlign,
        ),
      ],
    );
  }
}
