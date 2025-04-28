import 'package:flutter/material.dart';

class AuthSnackBar extends StatelessWidget {
  final String message;
  final Color iconColor;
  final IconData icon;

  const AuthSnackBar({
    super.key,
    required this.message,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 25, color: iconColor),
        const SizedBox(width: 10),
        Expanded(child: Text(message, style: textStyle.labelMedium)),
      ],
    );
  }
}
