import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

class CustomDropdownAuth<T> extends ConsumerWidget {
  final String hintText;
  final AsyncValue<List<T>> itemsData;
  final T? value;
  final ValueChanged<T?> onChanged;
  final bool isFilled;
  final String Function(T)? displayText;

  const CustomDropdownAuth({
    super.key,
    required this.hintText,
    required this.itemsData,
    this.value,
    required this.onChanged,
    required this.isFilled,
    this.displayText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      width: 340,
      child: IntrinsicHeight(
        child: itemsData.when(
          data: (data) {
            if (data.isEmpty) {
              return Text(
                'Нет доступных вариантов',
                style: textStyle.titleMedium?.copyWith(color: Colors.grey),
              );
            }

            return DropdownButtonFormField<T>(
              isExpanded: true,
              style: textStyle.titleMedium,
              dropdownColor: AppColors.backgroundColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                hintText: hintText,
                hintStyle: textStyle.titleMedium,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.inActiveColor,
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
                        isFilled
                            ? AppColors.activeColor
                            : AppColors.withOpacityColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items:
                  data.map((item) {
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        displayText?.call(item) ?? item.toString(),
                        style: textStyle.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
              value: value,
              onChanged: onChanged,
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return Text(
              'Ошибка загрузки',
              style: textStyle.titleMedium?.copyWith(
                color: AppColors.googleColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
