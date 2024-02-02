import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

enum CustomButtonVariant {
  primary,
  outline,
  danger,
  gray,
  light,
}

enum CustomButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final CustomButtonVariant variant;
  final bool disabled;
  final bool loading;
  final Icon? iconLeft;
  final Icon? iconRight;
  final bool rounded;
  final CustomButtonSize size;
  final String? loadingText;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.variant = CustomButtonVariant.primary,
      this.disabled = false,
      this.loading = false,
      this.iconLeft,
      this.iconRight,
      this.rounded = false,
      this.loadingText,
      this.size = CustomButtonSize.medium})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? textColor;
    Color? borderColor;
    Color? disabledColor;
    Color? disabledTextColor;
    Color? disabledBorderColor;
    int? padding;
    int? borderRadius;
    int fontSize = 16;
    int height = 48;

    switch (widget.variant) {
      case CustomButtonVariant.primary:
        backgroundColor = primaryColor.shade900;
        textColor = Colors.white;
        borderColor = primaryColor.shade900;
        disabledColor = Colors.black87;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.black87;
        break;
      case CustomButtonVariant.outline:
        backgroundColor = Colors.white;
        textColor = primaryColor.shade900;
        borderColor = primaryColor.shade900;
        disabledColor = Colors.white;
        disabledTextColor = Colors.black54;
        disabledBorderColor = Colors.black54;
        break;
      case CustomButtonVariant.danger:
        backgroundColor = ThemeColors.redColor;
        textColor = Colors.white;
        borderColor = ThemeColors.redColor;
        disabledColor = Colors.black87;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.black87;
        break;
      case CustomButtonVariant.gray:
        backgroundColor = ThemeColors.lightColor;
        textColor = primaryColor.shade900;
        borderColor = Colors.grey;
        disabledColor = Colors.grey;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.grey;
      case CustomButtonVariant.light:
        backgroundColor = ThemeColors.lightGrayColor;
        textColor = primaryColor.shade900;
        borderColor = Colors.grey;
        disabledColor = Colors.grey;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.grey;
      default:
        backgroundColor = primaryColor.shade900;
        textColor = Colors.white;
        borderColor = primaryColor.shade900;
        disabledColor = Colors.black87;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.black87;
    }

    switch (widget.size) {
      case CustomButtonSize.small:
        padding = 5;
        borderRadius = 7;
        fontSize = 14;
        height = 40;
        break;
      case CustomButtonSize.medium:
        padding = 10;
        borderRadius = 8;
        fontSize = 15;
        height = 46;
        break;
      case CustomButtonSize.large:
        padding = 9;
        borderRadius = 8;
        fontSize = 16;
        height = 50;
        break;
      default:
        padding = 10;
        borderRadius = 8;
        fontSize = 14;
    }

    return SizedBox(
      height: height.toDouble(),
      child: ElevatedButton(
        onPressed:
            widget.disabled ? null : widget.onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledForegroundColor: textColor,
          disabledBackgroundColor: disabledColor,
          side: widget.variant == CustomButtonVariant.outline
              ? BorderSide(
                  color: widget.disabled ? disabledBorderColor : borderColor,
                  width: 1,
                )
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              widget.rounded ? 50 : borderRadius.toDouble(),
            ),
          ),
          padding: EdgeInsets.only(
            left: padding.toDouble(),
            right: padding.toDouble(),
            top: GetPlatform.isDesktop
                ? padding.toDouble() - 2
                : padding.toDouble(),
            bottom: padding.toDouble(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.loading
                ? Row(
                    children: [
                      SizedBox(
                        width: 17,
                        height: 17,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(width: 10)
                    ],
                  )
                : widget.iconLeft != null
                    ? Row(
                        children: [
                          widget.iconLeft!,
                          const SizedBox(width: 5),
                        ],
                      )
                    : const SizedBox(width: 0),
            Text(
              widget.loading ? widget.loadingText ?? 'Loading...' : widget.text,
              style: TextStyle(
                color: widget.disabled ? disabledTextColor : textColor,
                fontSize: fontSize.toDouble(),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.iconRight != null) const SizedBox(width: 5),
            if (widget.iconRight != null) widget.iconRight!,
          ],
        ),
      ),
    );
  }
}
