import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

class CustomTextFieldPersonalAccount extends ConsumerWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final bool isFilled;
  final bool isEdit;
  final bool hasFocus;
  final Function(String)? onChanged;

  const CustomTextFieldPersonalAccount({
    super.key,
    required this.controller,
    required this.text,
    this.obscureText = false,
    required this.isFilled,
    required this.isEdit,
    required this.hasFocus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(33, 0, 33, 24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: textStyle.titleMedium?.copyWith(fontSize: 18),
            ),
          ),

          TextFormField(
            onChanged: isEdit ? onChanged : null,
            enabled: isEdit,
            style:
                isEdit
                    ? textStyle.bodyLarge
                    : textStyle.bodyLarge?.copyWith(
                      color: AppColors.withOpacityColor,
                    ),
            controller: controller,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.inActiveColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      hasFocus
                          ? AppColors.withOpacityColor
                          : AppColors.inActiveColor,
                ),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.inActiveColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.withOpacityColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
