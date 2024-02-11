// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class AppItemListWidget<T> extends StatelessWidget {
  final List<T> values;
  final List<String> mainNames;
  final List<String> secondText;
  final List<Uint8List> photoList;
  final void Function(T) onTapThreeDots;
  final void Function(T)? onItemTap;

  const AppItemListWidget({
    super.key,
    required this.values,
    required this.mainNames,
    required this.secondText,
    required this.photoList,
    required this.onTapThreeDots,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Color(0xff363B62),
          ),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: mainNames.length,
          itemBuilder: (context, index) {
            final content = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: photoList[index].isNotEmpty
                              ? Image.memory(
                                  photoList[index],
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: AppColors.photoColorGray,
                                ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mainNames[index],
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.bold19.value.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(secondText[index], overflow: TextOverflow.ellipsis, style: AppTextStyle.medium11.value.copyWith(color: AppColors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => onTapThreeDots.call(values[index]),
                  child: SvgPicture.asset(SvgIcons.dots),
                ),
              ],
            );
            return onItemTap != null
                ? InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      onItemTap?.call(values[index]);
                    },
                    child: content,
                  )
                : content;
          },
        ),
      ),
    );
  }
}
