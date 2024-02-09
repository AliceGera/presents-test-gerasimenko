import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';

import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';

class EditOrDeleteDialogWidget extends StatelessWidget {
  final Function() editGiftsScreen;
  final Function() deleteGift;

  const EditOrDeleteDialogWidget({
    super.key,
    required this.editGiftsScreen,
    required this.deleteGift,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColors.photoColorGray,
      surfaceTintColor: Colors.transparent,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: deleteGift,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(SvgIcons.delete),
                      Text('Delete', style: AppTextStyle.regular13.value.copyWith(color: AppColors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: editGiftsScreen,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(SvgIcons.editPen),
                      Text('Edit', style: AppTextStyle.regular13.value.copyWith(color: AppColors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
