// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';

import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';

import 'package:flutter_template/assets/res/resources.dart';

class AppAddOrEditGiftWidget extends StatelessWidget {

  final VoidCallback? closeScreen;
  final VoidCallback? whoGavePresentScreen;
  final VoidCallback? chooseHolidayNameScreen;
  final  TextEditingController textController ;

  const AppAddOrEditGiftWidget({super.key,

    required this.whoGavePresentScreen,
    required this.chooseHolidayNameScreen,
 this.closeScreen, required this.textController,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.darkBlue),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 88, width: 88, color: AppColors.gray),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      Text('Rate the gift', style: AppTextStyle.regular14.value.copyWith(color: AppColors.white)),

                      ///
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.darkBlue),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppTextFieldWidget(
                    text: 'Gift name',
                    controller: textController,

                    //formKey: wm.formEmailKey,
                    //validatorText: wm.getEmailValidationTex,
                  ),
                  const SizedBox(height: 8),
                  InkWell(onTap:whoGavePresentScreen, child: ChooseWidget(text: 'Who gave it')),
                  const SizedBox(height: 8),
                  InkWell(onTap:chooseHolidayNameScreen,child: ChooseWidget(text: 'Name of the holiday')),
                  const SizedBox(height: 8),
                  AppTextFieldWidget(
                    text: 'A comment',
                    controller: textController,
                    lines: 7,
                    //formKey: wm.formEmailKey,
                    //validatorText: wm.getEmailValidationTex,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: AppButtonWidget(title: 'Cancel', color: AppColors.white, textColor: AppColors.black, onPressed: closeScreen)),
              const SizedBox(width: 8),
              const Expanded(child: AppButtonWidget(title: 'Save')),
            ],
          ),
        ],
      ),
    );
  }
}
class ChooseWidget extends StatelessWidget {
  ChooseWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.textFieldBackground),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyle.regular13.value.copyWith(color: AppColors.white)),
            SvgPicture.asset(SvgIcons.checkChoose),
          ],
        ),
      ),
    );
  }
}
