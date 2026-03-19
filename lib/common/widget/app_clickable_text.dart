import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/app_text_style.dart';

class AppClickableText extends StatelessWidget {
  const AppClickableText({
    super.key,
    required this.prefixText,
    required this.linkText,
    required this.onTap,
  });

  final String prefixText;
  final String linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: prefixText, style: AppTextStyle.body),
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

/*
⚠️ TapGestureRecognizer inside StatelessWidget → potential memory leak
 */

/*
  // Why we doesn't use other RichText
 */
/*
// Understand ths Code .. and other
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(navigatorName);
              },
 */
