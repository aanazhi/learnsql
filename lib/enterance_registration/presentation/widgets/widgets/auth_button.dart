import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';

class AuthButton extends StatelessWidget {
  final bool isFilled;
  final VoidCallback? onPressed;
  final String text;
  final Color activeColor;
  final Color inactiveColor;
  final Color textActiveColor;
  final Color textInactiveColor;
  final bool hasBorder;
  final Color borderColor;
  final double? height;
  final double? width;

  const AuthButton({
    super.key,
    required this.isFilled,
    this.onPressed,
    required this.text,
    this.activeColor = AppColors.activeColor,
    this.inactiveColor = AppColors.backgroundColor,
    this.textActiveColor = AppColors.backgroundColor,
    this.textInactiveColor = AppColors.withOpacityColor,
    this.hasBorder = false,
    this.borderColor = AppColors.activeColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final heightMin = height ?? 54;
    final widthMin = width ?? 311;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? activeColor : inactiveColor,
        minimumSize: Size(widthMin, heightMin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side:
              hasBorder
                  ? BorderSide(
                    color: isFilled ? borderColor : inactiveColor,
                    width: 2,
                  )
                  : BorderSide.none,
        ),
      ),
      child: Text(
        text,
        style: textStyle.titleMedium?.copyWith(
          color: isFilled ? textActiveColor : textInactiveColor,
        ),
      ),
    );
  }
}
