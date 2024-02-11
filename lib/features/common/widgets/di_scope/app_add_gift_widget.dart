// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';

class AppAddGiftWidget extends StatelessWidget {
  final VoidCallback? closeScreen;
  final VoidCallback choosePersonScreenOnTap;
  final ValueNotifier<String?> personState;
  final ValueNotifier<String?> holidayNameState;
  final VoidCallback? chooseHolidayNameScreen;
  final TextEditingController giftNameController;
  final TextEditingController commentController;
  final TextEditingController? priceController;
  final Gift gift;
  final VoidCallback loadAgain;

  final bool isReceived;
  void Function(Uint8List photo) savePhoto;
  final Future<void> Function() addGift;
  final void Function(int)? rateOnTap;

  AppAddGiftWidget({
    required this.addGift,
    required this.holidayNameState,
    required this.choosePersonScreenOnTap,
    required this.personState,
    required this.chooseHolidayNameScreen,
    required this.commentController,
    required this.giftNameController,
    required this.gift,
    required this.loadAgain,
    required this.savePhoto,
    required this.isReceived,
    super.key,
    this.rateOnTap,
    this.closeScreen,
    this.priceController,
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
                  AppCameraWidget(
                    savePhoto: savePhoto,
                    photo: gift.photo,
                  ),
                  const SizedBox(width: 30),
                  if (isReceived)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rate the gift',
                          style: AppTextStyle.regular14.value.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                rateOnTap?.call(index + 1);
                              },
                              child: Icon(
                                Icons.star,
                                size: 30,
                                color: (index + 1 <= gift.giftRaiting) ? AppColors.fillStar : AppColors.emptyStar,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextFieldWidget(
                    text: 'Gift name',
                    controller: giftNameController,
                  ),
                  const SizedBox(height: 8),
                  Text('Who gave it', style: AppTextStyle.regular12.value.copyWith(color: AppColors.white)),
                  ValueListenableBuilder<String?>(
                    builder: (context, person, child) {
                      return InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: choosePersonScreenOnTap,
                          child: ChooseWidget(text: person ?? 'Who gave it'));
                    },
                    valueListenable: personState,
                  ),
                  const SizedBox(height: 8),
                  Text('Name of the holiday', style: AppTextStyle.regular12.value.copyWith(color: AppColors.white)),
                  ValueListenableBuilder<String?>(
                    builder: (context, holidayName, child) {
                      return InkWell(
                        onTap: chooseHolidayNameScreen,
                        child: ChooseWidget(
                          text: holidayName ?? 'Name of the holiday',
                        ),
                      );
                    },
                    valueListenable: holidayNameState,
                  ),
                  const SizedBox(height: 8),
                  AppTextFieldWidget(
                    text: 'Price',
                    controller: priceController,
                    isPrice: true,
                  ),
                  const SizedBox(height: 8),
                  AppTextFieldWidget(
                    text: 'A comment',
                    controller: commentController,
                    lines: 7,
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
              Expanded(
                child: AppButtonWidget(
                  title: 'Save',
                  onPressed: () async {
                    await addGift();
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
    super.key,
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
