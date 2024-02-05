// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class AppItemListWidget extends StatelessWidget {
  final VoidCallback onPressedEdit;
  final List<String> mainNames;
  final List<String> secondText;
  const AppItemListWidget({
    super.key,
    required this.onPressedEdit,
    required this.mainNames,
    required this.secondText,
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
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 60,
                      width: 60,
                      color: const Color(0xff363B62),
                    ),
                    /*child: Image.network(
                          //subject['images']['large'],
                          height: 150.0,
                          width: 100.0,
                        ),*/
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mainNames[index], style: AppTextStyle.bold19.value.copyWith(color: AppColors.white)),
                        const SizedBox(height: 8),
                        Text(secondText[index], style: AppTextStyle.medium11.value.copyWith(color: AppColors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: onPressedEdit,
                child: SvgPicture.asset(SvgIcons.dots),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
