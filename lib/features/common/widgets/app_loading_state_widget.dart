import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

/// {@template loading_holidays_widget.class}
/// Виджет, который выводится при загрузке экрана профиля.
/// {@endtemplate}
class AppLoadingStateWidget extends StatelessWidget {
  /// Виджет-модель для экрана holidays

  /// {@macro loading_holidays_widget.class}
  const AppLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.gray.withOpacity(0.2),
            highlightColor: AppColors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BoxWidget(boxHeight: 150),
                SizedBox(height: 20),
                _BoxWidget(boxHeight: 150),
                SizedBox(height: 20),
                _BoxWidget(boxHeight: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BoxWidget extends StatelessWidget {
  final double boxHeight;

  const _BoxWidget({required this.boxHeight});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.gray,
      ),
      child: SizedBox(height: boxHeight, width: double.infinity),
    );
  }
}
