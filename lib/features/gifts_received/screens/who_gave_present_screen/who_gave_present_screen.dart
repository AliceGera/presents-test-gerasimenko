import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_bottom_sheet_widget.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/who_gave_present_screen/who_gave_present_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for GiftsReceivedScreen feature.
@RoutePage(
  name: AppRouteNames.whoGavePresentScreen,
)
class WhoGavePresentScreen extends ElementaryWidget<IWhoGavePresentScreenWidgetModel> {
  /// Create an instance [WhoGavePresentScreen].
  const WhoGavePresentScreen({
    Key? key,
    WidgetModelFactory wmFactory = whoGavePresentScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IWhoGavePresentScreenWidgetModel wm) {
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
              child: Text('Who gave it ', style: AppTextStyle.bold19.value.copyWith(color: AppColors.white)),
            ),
          ],
        ),
      ),
      body: _Body(closeScreen: wm.closeScreen,),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;
  //final VoidCallback openEditScreen;
  _Body({
    required this.closeScreen,
   // required this.openEditScreen,
  });

  final List<String> mainNames = ['Angela Miller', 'Jessica Garcia', 'Natalie Lewis', 'Stephen White', 'Thomas Brown', 'Young Robinson'];
  final List<String> secondText = ['A comment', 'A comment', 'A comment', 'A comment', 'A comment', 'A comment'];
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppItemListWidget(onPressedEdit: (){}, mainNames: mainNames, secondText: secondText),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: AppButtonWidget(
              title: 'Add a person +',
              onPressed: () {
                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                  backgroundColor: AppColors.darkBlue,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return AppBottomSheetWidget(closeScreen: closeScreen, textController: textController);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
