import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

class FullScreenImage extends ConsumerWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: SizedBox(
          width: 250,
          height: 35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.backgroundColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppColors.inActiveColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: AppColors.activeColor,
                  size: 24,
                ),
                Text(
                  'К описанию базы данных',
                  style: textStyle.bodyMedium?.copyWith(
                    color: AppColors.activeColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
