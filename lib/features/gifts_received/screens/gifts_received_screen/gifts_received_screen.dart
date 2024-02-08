import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/widgets/app_gifts_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// Main widget for GiftsReceivedScreen feature.
@RoutePage(
  name: AppRouteNames.giftsReceivedScreen,
)
class GiftsReceivedScreen extends ElementaryWidget<IGiftsReceivedScreenWidgetModel> {
  /// Create an instance [GiftsReceivedScreen].
  const GiftsReceivedScreen({
    Key? key,
    WidgetModelFactory wmFactory = giftsReceivedScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGiftsReceivedScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            'Gifts received',
            style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
          ),
        ),
      ),
      body: _Body(
        openAddGiftScreen: wm.openAddGiftScreen,
        editGiftsScreen: wm.editGiftsScreen,
        giftsState: wm.giftsState,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openAddGiftScreen;
  final void Function(Gift gift, Holiday holiday) editGiftsScreen;
  UnionStateNotifier<List<HolidayWithGiftsData>> giftsState;

  _Body({
    required this.openAddGiftScreen,
    required this.editGiftsScreen,
    required this.giftsState,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<HolidayWithGiftsData>>(
      unionStateListenable: giftsState,
      builder: (_, gifts) {
        return AppGiftWidget(
          editGiftsScreen: editGiftsScreen.call,
          holidayWithGifts: gifts,
          //values: gifts,
          //editGiftReceived: editGiftReceived,
          openAddGiftScreen: openAddGiftScreen,
        );
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
    );
  }
}
