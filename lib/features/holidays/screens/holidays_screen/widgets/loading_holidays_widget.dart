import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

/// {@template loading_holidays_widget.class}
/// Виджет, который выводится при загрузке экрана профиля.
/// {@endtemplate}
class LoadingHolidaysWidget extends StatelessWidget {
  /// Виджет-модель для экрана holidays

  /// {@macro loading_holidays_widget.class}
  const LoadingHolidaysWidget({super.key});

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
              children: [
                _BoxWidget(boxHeight: 270),
                SizedBox(height: 16),
                Padding(padding: EdgeInsets.only(right: 210), child: _BoxWidget(boxHeight: 30)),
                SizedBox(height: 8),
                Padding(padding: EdgeInsets.only(right: 150), child: _BoxWidget(boxHeight: 30)),
                SizedBox(height: 8),
                Padding(padding: EdgeInsets.only(right: 83), child: _BoxWidget(boxHeight: 30)),
                SizedBox(height: 16),
                _BoxWidget(boxHeight: 40),
                SizedBox(height: 40),
                Padding(padding: EdgeInsets.only(right: 200), child: _BoxWidget(boxHeight: 30)),
                SizedBox(height: 16),
                Row(children: [
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 10), child: _BoxWidget(boxHeight: 30))),
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 30), child: _BoxWidget(boxHeight: 30))),
                ]),
                SizedBox(height: 8),
                Row(children: [
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 10), child: _BoxWidget(boxHeight: 30))),
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 10), child: _BoxWidget(boxHeight: 30))),
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 60), child: _BoxWidget(boxHeight: 30))),
                ]),
                SizedBox(height: 12),
                _BoxWidget(boxHeight: 90),
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
