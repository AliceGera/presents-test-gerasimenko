import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_failed_state_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/common/widgets/app_loading_state_widget.dart';
import 'package:flutter_template/features/common/widgets/choose_edit_or_delete_dialog_widget.dart';
import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';
import 'package:flutter_template/features/holidays/screens/holidays_screen/holidays_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:intl/intl.dart';
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
        wm: wm,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final IHolidaysScreenWidgetModel wm;

  const _Body({
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<Holiday>>(
      unionStateListenable: wm.holidaysState,
      builder: (_, holidays) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppItemListWidget<Holiday>(
                mainNames: holidays.map((e) => e.holidayName).toList(),
                secondText: holidays.map((e) => e.holidayDate != null ? DateFormat('dd.MM.yyyy').format(e.holidayDate!) : '').toList(),
                photoList: holidays.map((e) => e.photo).toList(),
                values: holidays,
                onItemTap: wm.openHolidayGiftsScreen,
                onTapThreeDots: (holiday) {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => ChooseEditOrDeleteDialogWidget(
                      icon: SvgIcons.showPresents,
                      firstText: 'Presents',
                      editGiftsScreen: () {
                        Navigator.pop(ctx);
                        wm.editHolidayScreen.call(holiday);
                      },
                      deleteGift: () {
                        Navigator.pop(ctx);
                        showDialog<void>(
                          context: context,
                          builder: (ctx) => DeleteDialogWidget(
                            deleteGift: () async {
                              Navigator.pop(ctx);
                              await wm.deleteHolidayScreen.call(holiday);
                            },
                          ),
                        );
                      },
                      chooseItem: () {
                        Navigator.pop(ctx);
                        wm.openHolidayGiftsScreen.call(holiday);
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AppButtonWidget(
                  title: 'Add a holiday +',
                  onPressed: wm.openAddHolidayScreen,
                ),
              ),
            ],
          ),
        );
      },
      loadingBuilder: (_, hotel) => const AppLoadingStateWidget(),
      failureBuilder: (_, exception, hotel) => AppFailedStateWidget(loadAgain: wm.loadAgain),
    );
  }
}
