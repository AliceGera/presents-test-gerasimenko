import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/common/widgets/choose_edit_or_delete_dialog_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/holiday_name_screen/holiday_name_screen_widget_model.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// Main widget for HolidayNameScreen feature.
@RoutePage(
  name: AppRouteNames.holidayNameScreen,
)
class HolidayNameScreen extends ElementaryWidget<IHolidayNameScreenWidgetModel> {
  /// Create an instance [HolidayNameScreen].
  const HolidayNameScreen({
    Key? key,
    WidgetModelFactory wmFactory = holidayNameScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHolidayNameScreenWidgetModel wm) {
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
        openNextScreen: wm.openAddHolidayScreen,
        chooseHolidayScreen: wm.chooseHoliday,
        loadAgain: wm.loadAgain,
        holidaysState: wm.holidaysState,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;

  final void Function(Holiday holiday) chooseHolidayScreen;
  final VoidCallback loadAgain;
  UnionStateNotifier<List<Holiday>> holidaysState;

  _Body({
    required this.chooseHolidayScreen,
    required this.openNextScreen,
    required this.loadAgain,
    required this.holidaysState,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<Holiday>>(
      unionStateListenable: holidaysState,
      builder: (_, holidays) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppItemListWidget<Holiday>(
                  mainNames: holidays.map((e) => e.holidayName).toList(),
                  secondText: holidays.map((e) => e.holidayDate).toList(),
                  photoList: holidays.map((e) => e.photo).toList(),
                  values: holidays,
                  onTapThreeDots: (holiday){
                    showDialog<void>(
                      context: context,
                      builder: (ctx) => ChooseEditOrDeleteDialogWidget(
                        firstText:'Choose',
                        icon:SvgIcons.checkChooseDialog,
          
                        editGiftsScreen: () {
                          Navigator.pop(ctx);
                          showModalBottomSheet<void>(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            backgroundColor: AppColors.darkBlue,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return EditHolidayScreen(
                                loadAgain: loadAgain,
                                holiday: holiday,
                                showInBottomSheet: true,
                              );
                            },
                          );
                        },
                        deleteGift: () {
                          Navigator.pop(ctx);
                          // showDialog<void>(
                          //   context: context,
                          //   builder: (ctx) => DeleteDialogWidget(
                          //     deleteGift: () async {
                          //       Navigator.pop(ctx);
                          //       await deleteHolidayScreen.call(holiday);
                          //     },
                          //   ),
                          // );
                        },
                        chooseItem: () {
                          Navigator.pop(ctx);
                          chooseHolidayScreen.call(holiday);
                        },
                      ),
                    );
                  },
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
          ),
        );
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
    );
  }
}
