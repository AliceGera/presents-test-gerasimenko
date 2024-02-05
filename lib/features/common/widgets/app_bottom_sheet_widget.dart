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

class AppBottomSheetWidget extends StatelessWidget {

  final VoidCallback? closeScreen;
  final  TextEditingController textController ;

  const AppBottomSheetWidget({super.key,


 this.closeScreen, required this.textController,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Add a holiday', style: AppTextStyle.bold19.value.copyWith(color: AppColors.white))),
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: closeScreen,
                    child: SvgPicture.asset(SvgIcons.close))
              ],
            ),
            AppTextFieldWidget(
              text: 'Name of the holiday',
              controller: textController,

              //formKey: wm.formEmailKey,
              //validatorText: wm.getEmailValidationTex,
            ),
            const SizedBox(height: 8),
            AppTextFieldWidget(
              text: 'Date',
              controller: textController,

              //formKey: wm.formEmailKey,
              //validatorText: wm.getEmailValidationTex,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 88,
                width: 88,
                color: AppColors.textFieldBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 40),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: closeScreen,
                        child: AppButtonWidget(title: 'Cancel', color: AppColors.white, textColor: AppColors.black, onPressed: closeScreen)),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: AppButtonWidget(
                      title: 'Save',
                      //onPressed: openNextScreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
