import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';
import 'package:flutter_template/features/holidays/screens/add_holiday_screen/add_holiday_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.addHolidayScreen,
)
class AddHolidayScreen extends ElementaryWidget<IAddHolidayScreenWidgetModel> {
  /// Create an instance [AddHolidayScreen].
  const AddHolidayScreen(
    this.loadAgain, {
    Key? key,
    WidgetModelFactory wmFactory = addHolidayScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);
  final VoidCallback loadAgain;

  @override
  Widget build(IAddHolidayScreenWidgetModel wm) {
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
                'Adding a holiday',
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
      body: _Body(
        loadAgain: loadAgain,
        closeScreen: wm.closeScreen,
        holidayNameController: wm.holidayNameController,
        dateController: wm.dateController,
        addHoliday: wm.addHoliday,
        savePhoto: wm.savePhoto,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  final Future<void> Function() addHoliday;
  final void Function(Uint8List photo) savePhoto;
  final VoidCallback loadAgain;
  final TextEditingController holidayNameController;
  final TextEditingController dateController;

  _Body({
    required this.closeScreen,
    required this.holidayNameController,
    required this.dateController,
    required this.addHoliday,
    required this.loadAgain,
    required this.savePhoto,
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
            text: 'Name of the holiday',
            controller: holidayNameController,
            //formKey: wm.formEmailKey,
            //validatorText: wm.getEmailValidationTex,
          ),
          const SizedBox(height: 8),
          AppTextFieldWidget(
            text: 'Date',
            controller: dateController,
            //formKey: wm.formEmailKey,
            //validatorText: wm.getEmailValidationTex,
          ),
          AppCameraWidget(savePhoto: savePhoto),
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
                    await addHoliday();
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
