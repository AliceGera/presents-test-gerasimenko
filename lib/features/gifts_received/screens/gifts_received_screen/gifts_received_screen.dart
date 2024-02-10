import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
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
      body: UnionStateListenableBuilder<List<HolidayWithGiftsData>>(
        unionStateListenable: wm.giftsState,
        builder: (_, gifts) {
          return AppGiftWidget(
            editGiftsScreen: wm.editGiftsScreen,
            holidayWithGifts: gifts,
            deleteGift: wm.deleteGift,
            openAddGiftScreen: wm.openAddGiftScreen,
          );
        },
        loadingBuilder: (_, hotel) => const SizedBox(),
        failureBuilder: (_, exception, hotel) => const SizedBox(),
      ),
    );
  }
}
