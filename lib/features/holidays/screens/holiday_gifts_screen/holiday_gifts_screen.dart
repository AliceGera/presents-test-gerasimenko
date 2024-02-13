import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_failed_state_widget.dart';
import 'package:flutter_template/features/common/widgets/app_loading_state_widget.dart';
import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';
import 'package:flutter_template/features/common/widgets/edit_or_delete_dialog_widget.dart';
import 'package:flutter_template/features/holidays/screens/holiday_gifts_screen/holiday_gifts_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// Main widget for HolidayGifts feature.
@RoutePage(
  name: AppRouteNames.holidayGiftsScreen,
)
class HolidayGiftsScreen extends ElementaryWidget<IHolidayGiftsScreenWidgetModel> {
  /// Create an instance [HolidayGiftsScreen].
  const HolidayGiftsScreen({
    required this.holiday,
    Key? key,
    WidgetModelFactory wmFactory = holidayGiftsScreenWmFactory,
  }) : super(wmFactory, key: key);
  final Holiday holiday;

  @override
  Widget build(IHolidayGiftsScreenWidgetModel wm) {
    return UnionStateListenableBuilder<HolidayWithGiftsData>(
      unionStateListenable: wm.holidayAndGiftsState,
      builder: (_, holidayWithGifts) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: Center(
              child: Text(
                holidayWithGifts.holiday.holidayName,
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Gifts received', style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white)),
                        InkWell(onTap: wm.openAddGiftReceivedScreen, child: SvgPicture.asset(SvgIcons.addGift)),
                      ],
                    ),
                  ),
                  GiftsWidget(
                    deleteGift: wm.deleteGift,
                    giftsCount: holidayWithGifts.giftsReceived.length,
                    holidayWithGifts: holidayWithGifts,
                    openEditGiftsScreen: wm.openEditReceivedGiftsScreen,
                    isReceived: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Gifts given', style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white)),
                        InkWell(onTap: wm.openAddGiftGivenScreen, child: SvgPicture.asset(SvgIcons.addGift)),
                      ],
                    ),
                  ),
                  GiftsWidget(
                    deleteGift: wm.deleteGift,
                    giftsCount: holidayWithGifts.giftsGiven.length,
                    holidayWithGifts: holidayWithGifts,
                    openEditGiftsScreen: wm.openEditGivenGiftsScreen,
                    isReceived: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loadingBuilder: (_, hotel) => const AppLoadingStateWidget(),
      failureBuilder: (_, exception, hotel) => AppFailedStateWidget(loadAgain: wm.loadAgain),
    );
  }
}

class GiftsWidget extends StatelessWidget {
  const GiftsWidget({
    required this.giftsCount,
    required this.holidayWithGifts,
    required this.deleteGift,
    required this.openEditGiftsScreen,
    required this.isReceived,
    super.key,
  });

  final bool isReceived;
  final void Function(Gift gift) deleteGift;
  final int giftsCount;
  final HolidayWithGiftsData holidayWithGifts;
  final void Function(Gift gift, Holiday holiday) openEditGiftsScreen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: giftsCount,
        itemBuilder: (context, index) => InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            openEditGiftsScreen.call(
              isReceived ? holidayWithGifts.giftsReceived[index] : holidayWithGifts.giftsGiven[index],
              holidayWithGifts.holiday,
            );
          },
          child: SizedBox(
            height: 250,
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (isReceived ? holidayWithGifts.giftsReceived[index].photo.isNotEmpty : holidayWithGifts.giftsGiven[index].photo.isNotEmpty)
                            ? Image.memory(
                                isReceived ? holidayWithGifts.giftsReceived[index].photo : holidayWithGifts.giftsGiven[index].photo,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: AppColors.photoColorGray,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Builder(builder: (context) {
                        return InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => showDialog<void>(
                              barrierDismissible: true,
                              context: context,
                              builder: (ctx) => EditOrDeleteDialogWidget(
                                    editGiftsScreen: () {
                                      Navigator.pop(ctx);
                                      openEditGiftsScreen.call(
                                        isReceived ? holidayWithGifts.giftsReceived[index] : holidayWithGifts.giftsGiven[index],
                                        holidayWithGifts.holiday,
                                      );
                                    },
                                    deleteGift: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (ctx) => DeleteDialogWidget(
                                          deleteGift: () async {
                                            Navigator.pop(ctx);
                                            deleteGift.call(isReceived ? holidayWithGifts.giftsReceived[index] : holidayWithGifts.giftsGiven[index]);
                                          },
                                        ),
                                      );
                                    },
                                  )),
                          child: SvgPicture.asset(SvgIcons.editGift),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  isReceived ? holidayWithGifts.giftsReceived[index].giftName : holidayWithGifts.giftsGiven[index].giftName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bold14.value.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  isReceived ? holidayWithGifts.giftsReceived[index].whoGave : holidayWithGifts.giftsGiven[index].whoGave,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.regular12.value.copyWith(color: AppColors.lightGray),
                ),
                const SizedBox(height: 8),
                if (isReceived)
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, itemIndex) => Icon(
                        Icons.star,
                        size: 20,
                        color: (itemIndex <=
                                (isReceived ? (holidayWithGifts.giftsReceived[index].giftRaiting - 1) : (holidayWithGifts.giftsGiven[index].giftRaiting - 1)))
                            ? AppColors.fillStar
                            : AppColors.emptyStar,
                      ),
                    ),
                  )
                else
                  Text(
                    '\$ ${holidayWithGifts.giftsGiven[index].giftPrice}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bold14.value.copyWith(color: AppColors.white),
                  ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 7),
      ),
    );
  }
}
