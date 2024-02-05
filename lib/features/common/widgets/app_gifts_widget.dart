// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';

import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';

import 'package:flutter_template/assets/res/resources.dart';

class AppGiftWidget extends StatelessWidget {
  final VoidCallback? openAddGiftScreen;
  final VoidCallback? editGiftReceived;
  final List<String> holidaysList;
  final List<List<String>> presentsList;
  final List<List<String>> namesList;
  final List<List<String>> starsList;

  const AppGiftWidget({
    super.key,
    required this.holidaysList,
    required this.presentsList,
    required this.namesList,
    required this.starsList,
    required this.editGiftReceived,
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
                itemCount: holidaysList.length,
                itemBuilder: (context, ind) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        holidaysList[ind],
                        style: AppTextStyle.medium16.value.copyWith(color: AppColors.white),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: presentsList[ind].length,
                        itemBuilder: (context, index) => SizedBox(
                          height: 250,
                          width: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(color: AppColors.gray, height: 170, width: double.infinity),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkWell(onTap: editGiftReceived, child: SvgPicture.asset(SvgIcons.editGift)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(presentsList[ind][index],
                                  maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.bold14.value.copyWith(color: AppColors.white)),
                              const SizedBox(height: 4),
                              Text(namesList[ind][index],
                                  maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.regular13.value.copyWith(color: AppColors.white)),
                              const SizedBox(height: 8),
                              SvgPicture.asset(starsList[ind][index]),
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
