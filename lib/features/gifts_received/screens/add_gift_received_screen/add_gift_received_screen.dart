import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// AddGiftReceived screens.
@RoutePage(
  name: AppRouteNames.addGiftReceivedScreen,
)
class AddGiftReceivedScreen extends ElementaryWidget<IAddGiftReceivedScreenWidgetModel> {
  /// Create an instance [AddGiftReceivedScreen].
  const AddGiftReceivedScreen(
    this.loadAgain, {
    Key? key,
    WidgetModelFactory wmFactory = addGiftReceivedScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);
  final VoidCallback loadAgain;

  @override
  Widget build(IAddGiftReceivedScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            const SizedBox(width: 36),
            Text('Adding a gift (gifts received)', style: AppTextStyle.bold19.value.copyWith(color: AppColors.white)),
          ],
        ),
      ),
      body: _Body(
        closeScreen: wm.closeScreen,
        whoGavePresentScreen: wm.whoGavePresentScreen,
        chooseHolidayNameScreen: wm.chooseHolidayNameScreen,
        savePhoto: wm.savePhoto,
        giftNameController: wm.giftNameController,
        commentController: wm.commentController,
        addGift: wm.addGift,
        loadAgain: loadAgain,
        giftsState: wm.giftsState,
        holidayNameState: wm.holidayNameState,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  final VoidCallback whoGavePresentScreen;
  final VoidCallback chooseHolidayNameScreen;
  final void Function(Uint8List photo) savePhoto;
  final TextEditingController giftNameController;
  final TextEditingController commentController;
  final Future<void> Function() addGift;
  final VoidCallback loadAgain;
  final UnionStateNotifier<Gift> giftsState;
  final ValueNotifier<String?> holidayNameState;

  _Body({
    required this.closeScreen,
    required this.whoGavePresentScreen,
    required this.chooseHolidayNameScreen,
    required this.savePhoto,
    required this.giftNameController,
    required this.commentController,
    required this.addGift,
    required this.loadAgain,
    required this.giftsState,
    required this.holidayNameState,
  });

  @override
  Widget build(BuildContext context) {
    return /*AppAddOrEditGiftWidget(
      closeScreen: closeScreen,
      whoGavePresentScreen: whoGavePresentScreen,
      chooseHolidayNameScreen: chooseHolidayNameScreen,
      textController: textController,
    );*/

        UnionStateListenableBuilder<Gift>(
      unionStateListenable: giftsState,
      builder: (_, gift) {
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
                      AppCameraWidget(savePhoto: savePhoto),
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
                        controller: giftNameController,
                        //formKey: wm.formEmailKey,
                        //validatorText: wm.getEmailValidationTex,
                      ),
                      const SizedBox(height: 8),
                      InkWell(onTap: whoGavePresentScreen, child: ChooseWidget(text: 'Who gave it')),
                      const SizedBox(height: 8),
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
                        text: 'A comment',
                        controller: commentController,
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
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
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
