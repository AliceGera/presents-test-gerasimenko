import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_add_or_edit_gift_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// EditGiftReceived screens.
@RoutePage(
  name: AppRouteNames.editGiftReceivedScreen,
)
class EditGiftReceivedScreen extends ElementaryWidget<IEditGiftReceivedScreenWidgetModel> {
  /// Create an instance [EditGiftReceivedScreen].
  const EditGiftReceivedScreen({
    Key? key,
    WidgetModelFactory wmFactory = editGiftReceivedScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IEditGiftReceivedScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Text(
                'Edit a gift (gifts received)',
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
      body: _Body(closeScreen: wm.closeScreen,whoGavePresentScreen: wm.whoGavePresentScreen,chooseHolidayNameScreen: wm.chooseHolidayNameScreen),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  final VoidCallback whoGavePresentScreen;
  final VoidCallback chooseHolidayNameScreen;
  _Body({required this.closeScreen,required this.whoGavePresentScreen,required this.chooseHolidayNameScreen});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppAddOrEditGiftWidget(
      closeScreen: closeScreen,
      whoGavePresentScreen: whoGavePresentScreen,
      chooseHolidayNameScreen: chooseHolidayNameScreen,
      textController: textController,
    );
  }
}
