import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

class BackButtonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;

  const BackButtonAppBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: AppColors.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.activeColor,
          ),
          iconSize: 30,
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
