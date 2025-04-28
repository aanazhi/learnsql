import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

class DraggableDebugButton extends ConsumerWidget {
  const DraggableDebugButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(debugDraggableProvider);

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.greyColor,
          mini: true,
          child: const Icon(Icons.bug_report, color: AppColors.backgroundColor),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          ref.read(debugDraggableProvider.notifier).state = details.offset;
        },
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/logs');
          },
          backgroundColor: AppColors.greyColor,
          mini: true,
          child: const Icon(Icons.bug_report, color: AppColors.backgroundColor),
        ),
      ),
    );
  }
}
