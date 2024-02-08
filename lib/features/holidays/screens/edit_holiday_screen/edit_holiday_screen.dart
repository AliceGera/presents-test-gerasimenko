import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.editHolidayScreen,
)
class EditHolidayScreen extends ElementaryWidget<IEditHolidayScreenWidgetModel> {
  /// Create an instance [EditHolidayScreen].
  const EditHolidayScreen({
    required this.loadAgain,
    required this.holiday,
    this.showInBottomSheet = false,
    Key? key,
    WidgetModelFactory wmFactory = editHolidayScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final VoidCallback loadAgain;
  final Holiday holiday;
  final bool? showInBottomSheet;

  @override
  Widget build(IEditHolidayScreenWidgetModel wm) {
    final body = _Body(
      loadAgain: loadAgain,
      closeScreen: wm.closeScreen,
      holiday: holiday,
      holidayNameController: wm.holidayNameController,
      dateController: wm.dateController,
      savePhoto: wm.savePhoto,
      editHoliday: wm.editHoliday,
    );
    return showInBottomSheet == true
        ? BottomSheet(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: Text(
                          'Edit a holiday',
                          style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                          highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.close)),
                    ],
                  ),
                ),
                body,
              ],
            ),
            initWidgetModel: () {
              wm.initBottomSheetWidgetModel(holiday);
            },
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.backgroundColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: wm.closeScreen,
                          child: SvgPicture.asset(SvgIcons.backArrow)),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: Text(
                          'Edit a holiday',
                          style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        await wm.deleteHoliday();
                        loadAgain.call();
                      },
                      child: SvgPicture.asset(SvgIcons.trash)),
                ],
              ),
            ),
            body: body,
          );
  }
}

class BottomSheet extends StatefulWidget {
  final Widget content;
  final VoidCallback initWidgetModel;

  const BottomSheet({
    super.key,
    required this.content,
    required this.initWidgetModel,
  });

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  void initState() {
    widget.initWidgetModel.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: AppColors.backgroundColor,
        child: widget.content,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  final Holiday holiday;
  final TextEditingController holidayNameController;
  final TextEditingController dateController;
  final void Function(Uint8List photo) savePhoto;
  final Future<void> Function() editHoliday;
  final VoidCallback loadAgain;

  const _Body({
    required this.closeScreen,
    required this.holiday,
    required this.holidayNameController,
    required this.dateController,
    required this.savePhoto,
    required this.editHoliday,
    required this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12),
          AppTextFieldWidget(
            text: 'Name of the holiday',
            controller: holidayNameController,
          ),
          const SizedBox(height: 8),
          AppTextFieldWidget(
            text: 'Date',
            controller: dateController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: AppCameraWidget(savePhoto: savePhoto, photo: holiday.photo),
          ),
          Row(
            children: [
              Expanded(
                child: AppButtonWidget(
                  title: 'Cancel',
                  color: AppColors.white,
                  textColor: AppColors.black,
                  onPressed: closeScreen,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButtonWidget(
                  title: 'Save',
                  onPressed: () async {
                    await editHoliday();
                    loadAgain.call();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
