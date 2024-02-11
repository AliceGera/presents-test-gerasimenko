import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_failed_state_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/common/widgets/app_loading_state_widget.dart';
import 'package:flutter_template/features/holiday_selection_screen/holiday_selection_screen_widget_model.dart';
import 'package:flutter_template/features/holidays/screens/add_holiday_screen/add_holiday_screen_export.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:intl/intl.dart';
import 'package:union_state/union_state.dart';

/// Main widget for HolidayNameScreen feature.
@RoutePage(
  name: AppRouteNames.holidayNameScreen,
)
class HolidaySelectionScreen extends ElementaryWidget<IHolidaySelectionScreenWidgetModel> {
  /// Create an instance [HolidaySelectionScreen].
  const HolidaySelectionScreen({
    this.updateHoliday,
    Key? key,
    WidgetModelFactory wmFactory = holidaySelectionScreenWmFactory,
  }) : super(wmFactory, key: key);

  final void Function(Holiday selectedHoliday)? updateHoliday;

  @override
  Widget build(IHolidaySelectionScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Text(
                'Holiday selection',
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
      body: _Body(
        wm: wm,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final IHolidaySelectionScreenWidgetModel wm;

  _Body({required this.wm});

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<Holiday>>(
      unionStateListenable: wm.holidaysState,
      builder: (_, holidays) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppItemListWidget<Holiday>(
                  mainNames: holidays.map((e) => e.holidayName).toList(),
                  secondText: holidays.map((e) => e.holidayDate != null ? DateFormat('dd.MM.yyyy').format(e.holidayDate!) : '').toList(),
                  photoList: holidays.map((e) => e.photo).toList(),
                  values: holidays,
                  onTapThreeDots: (holiday) {
                    showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      backgroundColor: AppColors.darkBlue,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return EditHolidayScreen(
                          loadAgain: () {
                            wm.loadAgain.call(selectedHoliday: holiday);
                          },
                          holiday: holiday,
                          showInBottomSheet: true,
                        );
                      },
                    );
                  },
                  onItemTap: wm.chooseHoliday,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: AppButtonWidget(
                    title: 'Add a holiday +',
                    onPressed: () {
                      showModalBottomSheet<void>(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        backgroundColor: AppColors.darkBlue,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return AddHolidayScreen(
                            loadAgain: wm.loadAgain,
                            showInBottomSheet: true,
                          );
                        },
                      );
                    }, // openNextScreen,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loadingBuilder: (_, hotel) => const AppLoadingStateWidget(),
      failureBuilder: (_, exception, hotel) => AppFailedStateWidget(loadAgain: wm.loadAgain),
    );
  }
}
