import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_bottom_sheet.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_date_picker_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';
import 'package:flutter_template/features/holidays/screens/add_holiday_screen/add_holiday_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:intl/intl.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.addHolidayScreen,
)
class AddHolidayScreen extends ElementaryWidget<IAddHolidayScreenWidgetModel> {
  /// Create an instance [AddHolidayScreen].
  const AddHolidayScreen({
    required this.loadAgain,
    this.showInBottomSheet = false,
    Key? key,
    WidgetModelFactory wmFactory = addHolidayScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final VoidCallback loadAgain;
  final bool? showInBottomSheet;

  @override
  Widget build(IAddHolidayScreenWidgetModel wm) {
    final body = _Body(
      wm: wm,
      loadAgain: loadAgain,
    );
    return showInBottomSheet == true
        ? AppBottomSheet(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: Text(
                          'Add a holiday',
                          style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: wm.closeScreen,
                        child: SvgPicture.asset(SvgIcons.close),
                      ),
                    ],
                  ),
                ),
                body,
              ],
            ),
            initWidgetModel: () {},
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              backgroundColor: AppColors.backgroundColor,
              title: Row(
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: wm.closeScreen,
                    child: SvgPicture.asset(SvgIcons.backArrow),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Text(
                      'Adding a holiday',
                      style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
            body: body,
          );
  }
}

class _Body extends StatelessWidget {
  final IAddHolidayScreenWidgetModel wm;
  final VoidCallback loadAgain;

  const _Body({
    required this.wm,
    required this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12),
          AppTextFieldWidget(
            formKey: wm.formHolidayNameKey,
            text: 'Name of the holiday',
            controller: wm.holidayNameController,
            validatorText: wm.getHolidayNameValidationText,
          ),
          const SizedBox(height: 8),
          Text(
            'Date',
            style: AppTextStyle.regular12.value.copyWith(color: AppColors.white),
          ),
          ValueListenableBuilder<DateTime?>(
            builder: (context, dateTime, child) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  final result = await showAppDatePicker(context);
                  if (result != null && result.isNotEmpty) {
                    wm.addDate(result.first);
                  }
                },
                child: ValueListenableBuilder<String?>(
                  builder: (context, dateTimeMessage, child) {
                    return ChooseWidget(
                      color: dateTimeMessage != null ? Colors.red : Colors.transparent,
                      text: dateTime != null ? DateFormat('dd.MM.yyyy').format(dateTime) : 'Date',
                      assetName: SvgIcons.datePicker,
                    );
                  },
                  valueListenable: wm.dateTimeMessageState,
                ),
              );
            },
            valueListenable: wm.dateTimeState,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: AppCameraWidget(savePhoto: wm.savePhoto),
          ),
          Row(
            children: [
              Expanded(
                child: AppButtonWidget(
                  title: 'Cancel',
                  color: AppColors.white,
                  textColor: AppColors.black,
                  onPressed: wm.closeScreen,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButtonWidget(
                  title: 'Save',
                  onPressed: () async {
                    await wm.addHoliday();
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

class ChooseWidget extends StatelessWidget {
  const ChooseWidget({
    required this.text,
    required this.assetName,
    required this.color,
    super.key,
  });

  final String text;
  final String assetName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.textFieldBackground,
        border: Border.all(color: color, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyle.regular13.value.copyWith(color: AppColors.white)),
            SvgPicture.asset(assetName),
          ],
        ),
      ),
    );
  }
}
