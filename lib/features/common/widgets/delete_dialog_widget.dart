import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class DeleteDialogWidget extends StatelessWidget {
  final VoidCallback? loadAgain;
  final Future<void> Function()? deleteGift;



  DeleteDialogWidget({
    super.key,
    this.deleteGift,
    this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.photoColorGray,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Delete', style: AppTextStyle.bold14.value.copyWith(color: AppColors.white)),
            const SizedBox(height: 16),
            Text('Are you sure you want to delete the gift?', style: AppTextStyle.regular12.value.copyWith(color: AppColors.white)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                    backgroundColor: MaterialStateProperty.all(AppColors.buttonColorGray),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: AppTextStyle.regular13.value.copyWith(color: AppColors.black),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                    backgroundColor: MaterialStateProperty.all(AppColors.buttonColorRed),
                  ),
                  onPressed: () async {

                      await deleteGift?.call();
                      loadAgain?.call();


                  },
                  child: Text(
                    'Delete',
                    style: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
