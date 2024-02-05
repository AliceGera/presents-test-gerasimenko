import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/holidays/screens/holidays_screen/holidays_screen_wm.dart';
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
      body: _Body(openNextScreen: wm.openNextScreen, editHolidayScreen: wm.editHolidayScreen),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;
  final VoidCallback editHolidayScreen;

   _Body({
    required this.openNextScreen,
    required this.editHolidayScreen,
  });
  final List<String> mainNames=['Saint Valentine’s Day','Halloween','John Smiths Birthday','New Year','Brandon Allens Birthday'];
  final List<String> secondText=['14.02.2023','31.11.2023','12.12.2023','01.01.2024','19.01.2024'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppItemListWidget(onPressedEdit: editHolidayScreen,mainNames:mainNames,secondText:secondText),
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
