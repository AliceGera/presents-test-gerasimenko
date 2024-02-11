import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_camera_widget.dart';
import 'package:flutter_template/features/common/widgets/app_textfield_widget.dart';
import 'package:flutter_template/features/common/widgets/di_scope/app_add_gift_widget.dart';
import 'package:flutter_template/features/gifts_given/screens/add_gift_given_screen/add_gift_given_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// AddGiftGiven screens.
@RoutePage(
  name: AppRouteNames.addGiftGivenScreen,
)
class AddGiftGivenScreen extends ElementaryWidget<IAddGiftGivenScreenWidgetModel> {
  /// Create an instance [AddGiftGivenScreen].
  const AddGiftGivenScreen(
    this.loadAgain, {
    Key? key,
    WidgetModelFactory wmFactory = addGiftGivenScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);
  final VoidCallback loadAgain;

  @override
  Widget build(IAddGiftGivenScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            const SizedBox(width: 36),
            Text('Adding a gift (gifts given)', style: AppTextStyle.bold19.value.copyWith(color: AppColors.white)),
          ],
        ),
      ),
      body: _Body(
        wm: wm,
        loadAgain: loadAgain,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final IAddGiftGivenScreenWidgetModel wm;
  final VoidCallback loadAgain;

  const _Body({
    required this.wm,
    required this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: UnionStateListenableBuilder<Gift>(
        unionStateListenable: wm.giftsState,
        builder: (_, gift) {
          return AppAddGiftWidget(
            addGift: wm.addGift,
            holidayNameState: wm.holidayNameState,
            choosePersonScreenOnTap: wm.choosePersonScreenOnTap,
            personState: wm.personState,
            chooseHolidayNameScreen: wm.chooseHolidayNameScreen,
            commentController: wm.commentController,
            giftNameController: wm.giftNameController,
            gift: gift,
            loadAgain: loadAgain,
            savePhoto: wm.savePhoto,
            isReceived: false,
          );
        },
        loadingBuilder: (_, hotel) => const SizedBox(),
        failureBuilder: (_, exception, hotel) => const SizedBox(),
      ),
    );
  }
}
