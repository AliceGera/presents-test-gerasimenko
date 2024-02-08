import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_add_or_edit_gift_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// EditGiftReceived screens.
@RoutePage(
  name: AppRouteNames.editGiftReceivedScreen,
)
class EditGiftReceivedScreen extends ElementaryWidget<IEditGiftReceivedScreenWidgetModel> {
  /// Create an instance [EditGiftReceivedScreen].
  const EditGiftReceivedScreen({
    required this.loadAgain,
    required this.holiday,
    required this.gift,
    Key? key,
    WidgetModelFactory wmFactory = editGiftReceivedScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final VoidCallback loadAgain;
  final Gift gift;
  final Holiday holiday;

  @override
  Widget build(IEditGiftReceivedScreenWidgetModel wm) {
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
                    'Edit a gift (gifts received)',
                    style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
            InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  await wm.deleteGift();
                  loadAgain.call();
                },
                child: SvgPicture.asset(SvgIcons.trash)),
          ],
        ),
      ),
      /*AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Text(
                'Edit a gift (gifts received)',
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),*/
      body: ValueListenableBuilder<Gift>(
        builder: (context, gift, child) {
          return _Body(
            closeScreen: wm.closeScreen,
            whoGavePresentScreen: wm.whoGavePresentScreen,
            chooseHolidayNameScreen: wm.chooseHolidayNameScreen,
            gift: gift,
            loadAgain: loadAgain,
            editGift: wm.editGift,
            giftNameController: wm.giftNameController,
            commentController: wm.commentController,
          );
        },
        valueListenable: wm.giftState,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  final VoidCallback whoGavePresentScreen;
  final VoidCallback chooseHolidayNameScreen;
  final VoidCallback loadAgain;
  final Gift gift;
  final Future<void> Function() editGift;
  final TextEditingController giftNameController;
  final TextEditingController commentController;

  _Body({
    required this.closeScreen,
    required this.whoGavePresentScreen,
    required this.chooseHolidayNameScreen,
    required this.loadAgain,
    required this.editGift,
    required this.giftNameController,
    required this.commentController,
    required this.gift,
  });

  @override
  Widget build(BuildContext context) {
    return AppAddOrEditGiftWidget(
      closeScreen: closeScreen,
      whoGavePresentScreen: whoGavePresentScreen,
      chooseHolidayNameScreen: chooseHolidayNameScreen,
      giftNameController: giftNameController,
      commentController: commentController,
      gift: gift,
      editGift: editGift,
      loadAgain: loadAgain,
    );
  }
}
