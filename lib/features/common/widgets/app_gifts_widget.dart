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
import 'package:intl/intl.dart';

class AppGiftWidget extends StatelessWidget {
  final VoidCallback? openAddGiftScreen;
  final List<HolidayWithGiftsData> holidayWithGifts;
  final void Function(Gift, Holiday) editGiftsScreen;
  final Future<void> Function(Gift) deleteGift;
  final bool isReceived;

  const AppGiftWidget({
    required this.editGiftsScreen,
    required this.deleteGift,
    required this.holidayWithGifts,
    required this.isReceived,
    super.key,
    this.openAddGiftScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, ind) => (isReceived ? holidayWithGifts[ind].giftsReceived.isNotEmpty : holidayWithGifts[ind].giftsGiven.isNotEmpty)
                  ? const SizedBox(height: 32)
                  : const SizedBox(),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: holidayWithGifts.length,
              itemBuilder: (context, ind) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isReceived ? holidayWithGifts[ind].giftsReceived.isNotEmpty : holidayWithGifts[ind].giftsGiven.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${holidayWithGifts[ind].holiday.holidayName}, ${holidayWithGifts[ind].holiday.holidayDate != null ? DateFormat('dd.MM.yyyy').format(holidayWithGifts[ind].holiday.holidayDate!) : ''}',
                        style: AppTextStyle.medium16.value.copyWith(color: AppColors.white),
                      ),
                    ),
                  if (isReceived ? holidayWithGifts[ind].giftsReceived.isNotEmpty : holidayWithGifts[ind].giftsGiven.isNotEmpty)
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: isReceived ? holidayWithGifts[ind].giftsReceived.length : holidayWithGifts[ind].giftsGiven.length,
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
                                      child: (isReceived
                                              ? holidayWithGifts[ind].giftsReceived[index].photo.isNotEmpty
                                              : holidayWithGifts[ind].giftsGiven[index].photo.isNotEmpty)
                                          ? Image.memory(
                                              isReceived ? holidayWithGifts[ind].giftsReceived[index].photo : holidayWithGifts[ind].giftsGiven[index].photo,
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
                                                      isReceived ? holidayWithGifts[ind].giftsReceived[index] : holidayWithGifts[ind].giftsGiven[index],
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
                                                          await deleteGift.call(isReceived
                                                              ? holidayWithGifts[ind].giftsReceived[index]
                                                              : holidayWithGifts[ind].giftsGiven[index]);
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
                                isReceived ? holidayWithGifts[ind].giftsReceived[index].giftName : holidayWithGifts[ind].giftsGiven[index].giftName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.bold14.value.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isReceived ? holidayWithGifts[ind].giftsReceived[index].whoGave : holidayWithGifts[ind].giftsGiven[index].whoGave,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.regular13.value.copyWith(color: AppColors.lightGray),
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
                                              (isReceived
                                                  ? (holidayWithGifts[ind].giftsReceived[index].giftRaiting - 1)
                                                  : (holidayWithGifts[ind].giftsGiven[index].giftRaiting - 1)))
                                          ? AppColors.fillStar
                                          : AppColors.emptyStar,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  '\$ ${holidayWithGifts[ind].giftsGiven[index].giftPrice}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.bold14.value.copyWith(color: AppColors.lightGray),
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
