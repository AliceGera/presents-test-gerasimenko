import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_add_gift_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// AddGiftReceived screens.
@RoutePage(
  name: AppRouteNames.addGiftReceivedScreen,
)
class AddGiftReceivedScreen extends ElementaryWidget<IAddGiftReceivedScreenWidgetModel> {
  /// Create an instance [AddGiftReceivedScreen].
  const AddGiftReceivedScreen({
    required this.loadAgain,
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
          return AppAddGiftWidget(
            formKey: wm.formGiftNameKey,
            addGift: wm.addGift,
            holidayNameState: wm.holidayNameState,
            choosePersonScreenOnTap: wm.choosePersonScreenOnTap,
            personState: wm.personState,
            chooseHolidayNameScreen: wm.chooseHolidayNameScreen,
            commentController: wm.commentController,
            giftNameController: wm.giftNameController,
            gift: gift,
            loadAgain: loadAgain,
            savePhoto: wm.savePhoto,
            isReceived: true,
            rateOnTap: wm.chooseRateOnTap,
            validatorText: wm.getGiftNameValidationText,
            holidayNameMessageState: wm.holidayNameMessageState,
            personMessageState: wm.personMessageState,
          );
        },
        loadingBuilder: (_, hotel) => const SizedBox(),
        failureBuilder: (_, exception, hotel) => const SizedBox(),
      ),
    );
  }
}
