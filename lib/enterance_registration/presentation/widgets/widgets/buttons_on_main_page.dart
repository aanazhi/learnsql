import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';

class ButtonsOnMainPage extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double top;

  const ButtonsOnMainPage({
    super.key,
    required this.onPressed,
    required this.top,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(top: top),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.inActiveColor,
          minimumSize: const Size(294, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Text(
          text,
          style: textStyle.titleLarge?.copyWith(color: AppColors.activeColor),
        ),
      ),
    );
  }
}
