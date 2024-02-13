// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';

class PersonBottomSheetWidget extends StatelessWidget {
  final VoidCallback closeScreen;
  final bool? isEdit;
  final Future<bool> Function() addOrEditPerson;
  final TextEditingController firstNameController;
  final TextEditingController commentController;
  final TextEditingController lastNameController;
  void Function(Uint8List photo) savePhoto;
  final VoidCallback loadAgain;
  final Uint8List? photo;
  final VoidCallback? cleanBottomSheetForAddPersonOnTap;
  final GlobalKey<FormState>? formFirstNameKey;
  final String? Function()? getLastNameValidationText;
  final String? Function()? getFirstNameValidationText;
  final GlobalKey<FormState>? formLastNameKey;

  PersonBottomSheetWidget({
    this.getLastNameValidationText,
    this.getFirstNameValidationText,
    this.formLastNameKey,
    this.formFirstNameKey,
    required this.closeScreen,
    required this.addOrEditPerson,
    required this.firstNameController,
    required this.commentController,
    required this.lastNameController,
    required this.savePhoto,
    required this.loadAgain,
    super.key,
    this.photo,
    this.isEdit,
    this.cleanBottomSheetForAddPersonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: Text(
                  isEdit == null ? 'Add a person' : 'Edit a person',
                  style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: closeScreen,
                child: SvgPicture.asset(SvgIcons.close),
              )
            ],
          ),
          AppCameraWidget(
            savePhoto: savePhoto,
            photo: photo,
          ),
          AppTextFieldWidget(
            formKey: formFirstNameKey,
            text: 'First name',
            controller: firstNameController,
            validatorText: getFirstNameValidationText,
          ),
          const SizedBox(height: 8),
          AppTextFieldWidget(
            formKey: formLastNameKey,
            text: 'Last Name',
            controller: lastNameController,
            validatorText: getLastNameValidationText,
          ),
          const SizedBox(height: 8),
          AppTextFieldWidget(
            text: 'comment',
            controller: commentController,
            lines: 6,
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
                      child: AppButtonWidget(
                        title: 'Cancel',
                        color: AppColors.white,
                        textColor: AppColors.black,
                        onPressed: closeScreen,
                      )),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppButtonWidget(
                    title: 'Save',
                    onPressed: () async {
                      final isSuccessfully = await addOrEditPerson();
                      if (isSuccessfully && cleanBottomSheetForAddPersonOnTap != null) {
                        cleanBottomSheetForAddPersonOnTap!();
                      }
                      loadAgain.call();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
