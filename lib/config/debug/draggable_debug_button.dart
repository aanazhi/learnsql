import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

class DraggableDebugButton extends ConsumerWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const DraggableDebugButton({super.key, required this.navigatorKey});

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
            navigatorKey.currentState?.pushNamed('/logs');
          },
          backgroundColor: AppColors.greyColor,
          mini: true,
          child: const Icon(Icons.bug_report, color: AppColors.backgroundColor),
        ),
      ),
    );
  }
}
