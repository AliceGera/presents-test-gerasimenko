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
        wm: wm,
        loadAgain: loadAgain,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final IAddGiftReceivedScreenWidgetModel wm;
  final VoidCallback loadAgain;

  _Body({
    required this.wm,
    required this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: UnionStateListenableBuilder<Gift>(
        unionStateListenable: wm.giftsState,
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
                        AppCameraWidget(savePhoto: wm.savePhoto),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rate the gift', style: AppTextStyle.regular14.value.copyWith(color: AppColors.white)),
                            SizedBox(
                              height: 45,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    wm.chooseRateOnTap.call(index+1);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    size: 30,
                                    color: gift.giftRaiting<index+1?AppColors.emptyStar:AppColors.fillStar,
                                  ),
                                ),
                              ),
                            ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFieldWidget(
                          text: 'Gift name',
                          controller: wm.giftNameController,
                        ),
                        const SizedBox(height: 8),
                        Text('Who gave it', style: AppTextStyle.regular12.value.copyWith(color: AppColors.white)),
                        ValueListenableBuilder<String?>(
                          builder: (context, person, child) {
                            return InkWell(onTap: wm.choosePersonScreenOnTap, child: ChooseWidget(text: person ?? 'Who gave it'));
                          },
                          valueListenable: wm.personState,
                        ),
                        const SizedBox(height: 8),
                        Text('Name of the holiday', style: AppTextStyle.regular12.value.copyWith(color: AppColors.white)),
                        ValueListenableBuilder<String?>(
                          builder: (context, holidayName, child) {
                            return InkWell(
                              onTap: wm.chooseHolidayNameScreen,
                              child: ChooseWidget(
                                text: holidayName ?? 'Name of the holiday',
                              ),
                            );
                          },
                          valueListenable: wm.holidayNameState,
                        ),
                        const SizedBox(height: 8),
                        AppTextFieldWidget(
                          text: 'A comment',
                          controller: wm.commentController,
                          lines: 7,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: AppButtonWidget(title: 'Cancel', color: AppColors.white, textColor: AppColors.black, onPressed: wm.closeScreen)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppButtonWidget(
                        title: 'Save',
                        onPressed: () async {
                          await wm.addGift();
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
      ),
    );
  }
}

class ChooseWidget extends StatelessWidget {
   const ChooseWidget({
    required this.text, super.key,
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
