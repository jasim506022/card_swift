import 'package:flutter/material.dart';

import '../style/app_text_style.dart';

class OutlinedTextButton extends StatelessWidget {
  const OutlinedTextButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.title,
  });

  final VoidCallback onPressed;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: BorderSide(color: color)),
      onPressed: onPressed,
      child: Text(title, style: AppTextStyle.button.copyWith(color: color)),
    );
  }
}
