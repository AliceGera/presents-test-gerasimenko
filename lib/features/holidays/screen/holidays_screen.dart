import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/holidays/screen/holidays_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for HolidaysScreen feature.
@RoutePage(
  name: AppRouteNames.holidaysScreen,
)
class HolidaysScreen extends ElementaryWidget<IHolidaysScreenWidgetModel> {
  /// Create an instance [HolidaysScreen].
  const HolidaysScreen({
    Key? key,
    WidgetModelFactory wmFactory = holidaysScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHolidaysScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            'Holidays',
            style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
          ),
        ),
      ),
      body: _Body(openNextScreen: wm.openNextScreen),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;

  const _Body({
    required this.openNextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xff363B62),
                ),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 11,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 60,
                            width: 60,
                            color: const Color(0xff363B62),
                          ),
                          /*child: Image.network(
                          //subject['images']['large'],
                          height: 150.0,
                          width: 100.0,
                        ),*/
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saint Valentine’s Day',
                                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(height: 8),
                              Text('14.02.2023', style: AppTextStyle.medium11.value.copyWith(color: AppColors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(SvgIcons.dots),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: AppButtonWidget(
              title: 'Add a holiday +',
              onPressed: openNextScreen,
            ),
          ),
        ],
      ),
    );
  }
}
