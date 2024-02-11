import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/widgets/app_failed_state_widget.dart';
import 'package:flutter_template/features/common/widgets/app_gifts_widget.dart';
import 'package:flutter_template/features/common/widgets/app_loading_state_widget.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// Main widget for GiftsGivenScreen feature.
@RoutePage(
  name: AppRouteNames.giftsGivenScreen,
)
class GiftsGivenScreen extends ElementaryWidget<IGiftsGivenScreenWidgetModel> {
  /// Create an instance [GiftsGivenScreen].
  const GiftsGivenScreen({
    Key? key,
    WidgetModelFactory wmFactory = giftsGivenScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGiftsGivenScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            'Gifts given',
            style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
          ),
        ),
      ),
      body: UnionStateListenableBuilder<List<HolidayWithGiftsData>>(
        unionStateListenable: wm.giftsState,
        builder: (_, gifts) {
          return AppGiftWidget(
            isReceived:false,
            editGiftsScreen: wm.editGiftsScreen,
            holidayWithGifts: gifts,
            deleteGift: wm.deleteGift,
            openAddGiftScreen: wm.openAddGiftScreen,
          );
        },
        loadingBuilder: (_, hotel) => const AppLoadingStateWidget(),
        failureBuilder: (_, exception, hotel) =>AppFailedStateWidget(loadAgain:wm.loadAgain),
      ),
    );
  }
}
