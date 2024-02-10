import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:shimmer/shimmer.dart';

/// {@template loading_holidays_widget.class}
/// Виджет, который выводится при загрузке экрана профиля.
/// {@endtemplate}
class FailedStateWidget extends StatelessWidget {
  /// Виджет-модель для экрана holidays

  /// {@macro loading_holidays_widget.class}
  const FailedStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SvgPicture.asset(
              SvgIcons.errorState,
              height: 160,
              width: 160,
            ),
            Text(
              'Oops! Something went wrong.',
              style: AppTextStyle.medium16.value.copyWith(color: AppColors.white),
            ),
            Text(
              'Try refreshing the page',
              style: AppTextStyle.regular12.value.copyWith(color: AppColors.lightGray),
            ),
            AppButtonWidget(title: 'Update', color: AppColors.green),
          ],
        ),
      ),
    );
  }
}
