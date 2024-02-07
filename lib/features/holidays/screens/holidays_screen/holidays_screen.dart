import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/holidays/screens/holidays_screen/holidays_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

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
      body: _Body(
        openNextScreen: wm.openAddHolidayScreen,
        editHolidayScreen: wm.editHolidayScreen,
        holidaysState: wm.holidaysState,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;
  final void Function(Holiday holiday) editHolidayScreen;
  UnionStateNotifier<List<Holiday>> holidaysState;

  _Body({
    required this.openNextScreen,
    required this.editHolidayScreen,
    required this.holidaysState,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<Holiday>>(
      unionStateListenable: holidaysState,
      builder: (_, holidays) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppItemListWidget<Holiday>(
                onPressedEdit: editHolidayScreen.call,
                mainNames: holidays.map((e) => e.holidayName).toList(),
                secondText: holidays.map((e) => e.holidayDate).toList(),
                photoList: holidays.map((e) => e.photo).toList(),
                values: holidays,
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
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
    );
  }
}
