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
import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';
import 'package:flutter_template/features/common/widgets/edit_or_delete_dialog_widget.dart';
import 'package:flutter_template/features/holidays/screens/holiday_gifts_screen/holiday_gifts_screen_wm.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            holiday.holidayName,
            //holidayWithGifts.holiday.holidayName,
            style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
          ),
        ),
      ),
      body: _Body(
        deleteGift: wm.deleteGift,
        openAddHolidayScreen: wm.openAddHolidayScreen,
        editHolidayScreen: wm.editHolidayScreen,
        holidayAndGiftsState: wm.holidayAndGiftsState,
        //holidayWithGifts: holidayWithGifts,
        openAddGiftReceivedScreen: wm.openAddGiftReceivedScreen,
        openEditGiftsScreen: wm.openEditGiftsScreen,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openAddHolidayScreen;
  final void Function(Holiday holiday) editHolidayScreen;
  final UnionStateNotifier<HolidayWithGiftsData> holidayAndGiftsState;
  final void Function(Gift gift) deleteGift;
  final VoidCallback openAddGiftReceivedScreen;
  final void Function(Gift gift, Holiday holiday) openEditGiftsScreen;

  _Body(
      {required this.openAddHolidayScreen,
      required this.editHolidayScreen,
      required this.holidayAndGiftsState,
      required this.deleteGift,
      required this.openAddGiftReceivedScreen,
      required this.openEditGiftsScreen});

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<HolidayWithGiftsData>(
      unionStateListenable: holidayAndGiftsState,
      builder: (_, holidayWithGifts) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gifts received', style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white)),
                  InkWell(onTap: openAddGiftReceivedScreen, child: SvgPicture.asset(SvgIcons.addGift)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: holidayWithGifts.giftsReceived.length,
                  itemBuilder: (context, index) => SizedBox(
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
                                child: holidayWithGifts.giftsReceived[index].photo.isNotEmpty
                                    ? Image.memory(
                                        holidayWithGifts.giftsReceived[index].photo,
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
                                  //barrierDismissible: true,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () => showDialog<void>(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (ctx) => EditOrDeleteDialogWidget(
                                            editGiftsScreen: () {
                                              Navigator.pop(ctx);
                                              openEditGiftsScreen.call(
                                                holidayWithGifts.giftsReceived[index],
                                                holidayWithGifts.holiday,
                                              );
                                            },
                                            deleteGift: () {
                                              showDialog<void>(
                                                context: context,
                                                builder: (ctx) => DeleteDialogWidget(
                                                  deleteGift: () async {
                                                    Navigator.pop(ctx);
                                                    deleteGift.call(holidayWithGifts.giftsReceived[index]);
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
                          holidayWithGifts.giftsReceived[index].giftName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bold14.value.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          holidayWithGifts.giftsReceived[index].whoGave,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 8),
                        //SvgPicture.asset(starsList[ind][index]),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(width: 7),
                ),
              ),
              /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gifts received', style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white)),
              SvgPicture.asset(SvgIcons.addGift),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: holidayWithGifts.giftsReceived.length,
              itemBuilder: (context, index) => SizedBox(
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
                            child: holidayWithGifts.giftsReceived[index].photo.isNotEmpty
                                ? Image.memory(
                                    holidayWithGifts.giftsReceived[index].photo,
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
                              //barrierDismissible: true,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => showDialog<void>(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (ctx) => EditOrDeleteDialogWidget(
                                        editGiftsScreen: () {
                                          */ /*editGiftsScreen.call(
                                        holidayWithGifts.gifts[index],
                                        holidayWithGifts.holiday,
                                      );*/ /*
                                          Navigator.pop(ctx);
                                        },
                                        deleteGift: () {
                                          showDialog<void>(
                                            context: context,
                                            builder: (ctx) => DeleteDialogWidget(
                                              deleteGift: () async {
                                                Navigator.pop(ctx);
                                                // await deleteGift.call(holidayWithGifts.gifts[index]);
                                              },
                                            ),
                                          );
                                        },
                                      )),
                              child: SvgPicture.asset(SvgIcons.editGift),
                            );
                          }),

                          //),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      holidayWithGifts.giftsReceived[index].giftName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.bold14.value.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      holidayWithGifts.giftsReceived[index].whoGave,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 8),
                    //SvgPicture.asset(starsList[ind][index]),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 7),
            ),
          ),*/
            ],
          ),
        );
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
    );
  }
}
