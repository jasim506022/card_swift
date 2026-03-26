import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/app_text_style.dart';

/// Widget that displays text with a clickable portion (link).
class AppClickableText extends StatelessWidget {
  const AppClickableText({
    super.key,
    required this.prefixText,
    required this.linkText,
    required this.onTap,
  });

  /// Normal text before the clickable part
  final String prefixText;

  /// Clickable text
  final String linkText;

  /// Clickable text
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: prefixText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: linkText,
            style: AppTextStyle.button.copyWith(
              color: AppColors.green,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
