import 'package:flutter/material.dart';

class TextOnMainPage extends StatelessWidget {
  final String text;
  final double top;
  final TextStyle textStyles;
  const TextOnMainPage({
    super.key,
    required this.text,
    required this.top,
    required this.textStyles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(text, style: textStyles),
    );
  }
}
