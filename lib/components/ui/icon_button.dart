import 'package:flutter/material.dart';
import '../../utils/colors.dart';

enum CustomIconButtonVariant { primary, outline, danger, gray, light }

enum CustomIconButtonSize {
  small,
  medium,
  large,
}

class CustomIconButton extends StatefulWidget {
  final Function onPressed;
  final CustomIconButtonVariant variant;
  final bool disabled;
  final bool loading;
  final IconData icon;
  final bool rounded;
  final CustomIconButtonSize size;
  const CustomIconButton(
      {Key? key,
      required this.onPressed,
      this.variant = CustomIconButtonVariant.primary,
      this.disabled = false,
      this.loading = false,
      required this.icon,
      this.rounded = false,
      this.size = CustomIconButtonSize.medium})
      : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? iconColor;
    Color? borderColor;
    Color? disabledColor;
    Color? disabledTextColor;
    Color? disabledBorderColor;
    int? borderRadius;
    int iconSize = 16;
    int size = 48;

    switch (widget.variant) {
      case CustomIconButtonVariant.primary:
        backgroundColor = primaryColor.shade900;
        iconColor = Colors.white;
        borderColor = primaryColor.shade900;
        disabledColor = Colors.black54;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.black54;
        break;
      case CustomIconButtonVariant.outline:
        backgroundColor = Colors.white;
        iconColor = primaryColor.shade900;
        borderColor = primaryColor.shade900;
        disabledColor = Colors.white;
        disabledTextColor = Colors.black54;
        disabledBorderColor = Colors.black54;
        break;
      case CustomIconButtonVariant.danger:
        backgroundColor = ThemeColors.redColor;
        iconColor = Colors.white;
        borderColor = ThemeColors.redColor;
        disabledColor = Colors.black54;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.black54;
        break;
      case CustomIconButtonVariant.gray:
        backgroundColor = ThemeColors.lightColor;
        iconColor = primaryColor.shade900;
        borderColor = Colors.grey;
        disabledColor = Colors.grey;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.grey;
      case CustomIconButtonVariant.light:
        backgroundColor = ThemeColors.lightGrayColor;
        iconColor = primaryColor.shade900;
        borderColor = Colors.grey;
        disabledColor = Colors.grey;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.grey;
      default:
        backgroundColor = primaryColor.shade900;
        iconColor = Colors.white;
        borderColor = primaryColor.shade900;
        disabledColor = Colors.black54;
        disabledTextColor = Colors.white;
        disabledBorderColor = Colors.black54;
    }

    switch (widget.size) {
      case CustomIconButtonSize.small:
        borderRadius = 7;
        iconSize = 20;
        size = 30;
        break;
      case CustomIconButtonSize.medium:
        borderRadius = 8;
        iconSize = 25;
        size = 40;
        break;
      case CustomIconButtonSize.large:
        borderRadius = 8;
        iconSize = 30;
        size = 46;
        break;
      default:
        borderRadius = 8;
        iconSize = 25;
        size = 40;
    }

    return SizedBox(
      width: size.toDouble(),
      height: size.toDouble(),
      child: ElevatedButton(
        onPressed:
            widget.disabled ? null : widget.onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: iconColor,
          disabledForegroundColor: iconColor,
          disabledBackgroundColor: disabledColor,
          side: widget.variant == CustomIconButtonVariant.outline
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
          padding: const EdgeInsets.all(3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.loading
                ? SizedBox(
                    width: 17,
                    height: 17,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: iconColor,
                    ),
                  )
                : Icon(widget.icon,
                    size: iconSize.toDouble(),
                    color: widget.disabled ? disabledTextColor : iconColor),
          ],
        ),
      ),
    );
  }
}
