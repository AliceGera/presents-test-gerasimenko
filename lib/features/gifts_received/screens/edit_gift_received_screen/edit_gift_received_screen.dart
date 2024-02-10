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
import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';
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
            Builder(builder: (context) {
              return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => showDialog<void>(
                        context: context,
                        builder: (ctx) => DeleteDialogWidget(
                          deleteGift: () async {
                            Navigator.pop(ctx);
                            await wm.deleteGift();
                          },
                          loadAgain: loadAgain,
                        ),
                      ),
                  child: SvgPicture.asset(SvgIcons.trash));
            }),
          ],
        ),
      ),
      body: ValueListenableBuilder<Gift>(
        builder: (context, gift, child) {
          return SingleChildScrollView(
            child: AppAddOrEditGiftWidget(
              savePhoto: wm.savePhoto,
              closeScreen: wm.closeScreen,
              personScreen: wm.choosePersonOnTap,
              chooseHolidayNameScreen: wm.chooseHolidayNameOnTap,
              giftNameController: wm.giftNameController,
              commentController: wm.commentController,
              gift: gift,
              editGift: wm.editGiftOnTap,
              loadAgain: loadAgain,
              rateOnTap: wm.rateOnTap,
              isEdit: true,
            ),
          );
        },
        valueListenable: wm.giftState,
      ),
    );
  }
}
