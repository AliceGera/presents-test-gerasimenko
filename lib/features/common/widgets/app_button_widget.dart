// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class AppButtonWidget extends StatelessWidget {
  final String title;
  final bool isEnable;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  const AppButtonWidget({
    required this.title,
    super.key,
    this.isEnable = true,
    this.onPressed,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color??AppColors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyle.bold16.value.copyWith(color: textColor?? AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
