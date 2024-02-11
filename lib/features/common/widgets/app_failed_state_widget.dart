import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';

/// {@template failed_state_widget.class}
/// Виджет, который выводится при ошибке экрана профиля.
/// {@endtemplate}
class AppFailedStateWidget extends StatelessWidget {
  /// {@macro failed_state_widget.class}
  AppFailedStateWidget({
    super.key,
    required this.loadAgain,
  });

void Function() loadAgain;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset(
              SvgIcons.errorState,
              height: 160,
              width: 160,
            ),
            const SizedBox(height: 40),
            Text(
              'Oops! Something went wrong.',
              style: AppTextStyle.medium16.value.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Try refreshing the page',
              style: AppTextStyle.regular12.value.copyWith(color: AppColors.lightGray),
            ),
            const SizedBox(height: 40),
            AppButtonWidget(
              title: 'Update',
              color: AppColors.green,
              onPressed: loadAgain,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
