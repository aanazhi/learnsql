import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

class CustomTextFormField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool isFilled;
  final double? height;
  final double? width;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    required this.isFilled,
    this.height,
    this.width,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      height: height ?? 65,
      width: width ?? 340,
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorMaxLines: 1,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          errorStyle: const TextStyle(fontSize: 14, height: 0.8),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.googleColor),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.transparent,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: textStyle.titleMedium,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  isFilled ? AppColors.activeColor : AppColors.withOpacityColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.activeColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  isFilled ? AppColors.activeColor : AppColors.withOpacityColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
