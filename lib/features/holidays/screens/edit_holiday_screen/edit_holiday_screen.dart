import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holidays_data.dart';
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
  const EditHolidayScreen(
    this.loadAgain, {
    required this.holiday,
    Key? key,
    WidgetModelFactory wmFactory = editHolidayScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);
  final VoidCallback loadAgain;
  final Holiday holiday;

  @override
  Widget build(IEditHolidayScreenWidgetModel wm) {
    return Scaffold(
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
                    highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
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
      body: _Body(
        loadAgain: loadAgain,
        closeScreen: wm.closeScreen,
        holiday: holiday,
        holidayNameController: wm.holidayNameController,
        dateController: wm.dateController,
        savePhoto: wm.savePhoto,
        editHoliday: wm.editHoliday,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12),
          /*_TextFieldWidget(
            text: 'Name of the holiday',
            //controller: wm.emailController,
            //formKey: wm.formEmailKey,
            //validatorText: wm.getEmailValidationTex,
          ),*/
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: AppCameraWidget(savePhoto: savePhoto, photoHoliday: holiday.photo),
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

/*
class _TextFieldWidget extends StatefulWidget {
  _TextFieldWidget({
    required this.text,
    // required this.formKey,
    // required this.controller,
    this.validatorText,
  });

  //final TextEditingController controller;
  //final GlobalKey<FormState> formKey;
  final String text;
  final String? Function()? validatorText;
  String? _currentValidationText;

  @override
  State<_TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<_TextFieldWidget> {
  _TextFieldWidgetState();

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: widget.formKey,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                setState(() {
                  widget._currentValidationText = widget.validatorText?.call();
                });
                return '';
              },
              //controller: widget.controller,
              decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: AppColors.textFieldBackground),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: AppColors.textFieldBackground),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.textFieldBackground, width: 0),
                ),
                fillColor: AppColors.textFieldBackground,
                filled: true,
                labelText: widget.text,
                labelStyle: const TextStyle(color: AppColors.white),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
