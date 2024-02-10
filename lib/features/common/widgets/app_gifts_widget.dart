// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';

import 'package:flutter_template/features/common/widgets/edit_or_delete_dialog_widget.dart';

class AppGiftWidget extends StatelessWidget {
  final VoidCallback? openAddGiftScreen;
  final List<HolidayWithGiftsData> holidayWithGifts;
  final void Function(Gift, Holiday) editGiftsScreen;
  final Future<void> Function(Gift) deleteGift;

  const AppGiftWidget({
    required this.editGiftsScreen,
    required this.deleteGift,
    required this.holidayWithGifts,
    super.key,
    this.openAddGiftScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                separatorBuilder: (context, ind) => const SizedBox(height: 32),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: holidayWithGifts.length,
                itemBuilder: (context, ind) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: holidayWithGifts[ind].giftsReceived.isNotEmpty
                          ? Text(
                              '${holidayWithGifts[ind].holiday.holidayName} ${holidayWithGifts[ind].holiday.holidayDate}',
                              style: AppTextStyle.medium16.value.copyWith(color: AppColors.white),
                            )
                          : const SizedBox(),
                    ),
                    if (holidayWithGifts[ind].giftsReceived.isNotEmpty)
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: holidayWithGifts[ind].giftsReceived.length,
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
                                        child: holidayWithGifts[ind].giftsReceived[index].photo.isNotEmpty
                                            ? Image.memory(
                                                holidayWithGifts[ind].giftsReceived[index].photo,
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
                                              context: context,
                                              builder: (ctx) => EditOrDeleteDialogWidget(
                                                    editGiftsScreen: () {
                                                      editGiftsScreen.call(
                                                        holidayWithGifts[ind].giftsReceived[index],
                                                        holidayWithGifts[ind].holiday,
                                                      );
                                                      Navigator.pop(ctx);
                                                    },
                                                    deleteGift: () {
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (ctx) => DeleteDialogWidget(
                                                          deleteGift: () async {
                                                            Navigator.pop(ctx);
                                                            await deleteGift.call(holidayWithGifts[ind].giftsReceived[index]);
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
                                  holidayWithGifts[ind].giftsReceived[index].giftName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.bold14.value.copyWith(color: AppColors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  holidayWithGifts[ind].giftsReceived[index].whoGave,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, itemIndex) => Icon(
                                      Icons.star,
                                      size: 20,
                                      color: (itemIndex <= holidayWithGifts[ind].giftsReceived[index].giftRaiting - 1) ? AppColors.fillStar : AppColors.emptyStar,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(width: 7),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: AppButtonWidget(
              title: 'Add a gift +',
              onPressed: openAddGiftScreen,
            ),
          ),
        ],
      ),
    );
  }
}
