import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
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
      body: _Body(
        openAddGiftScreen: wm.openAddGiftScreen,
        editGiftReceived: wm.editGiftReceived,
        giftsState: wm.giftsState,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openAddGiftScreen;
  final VoidCallback editGiftReceived;
  UnionStateNotifier<List<HolidayWithGiftsData>> giftsState;

  _Body({
    required this.openAddGiftScreen,
    required this.editGiftReceived,
    required this.giftsState,
  });

  final List<String> holidaysList = [
    'Saint Valentine’s Day, 14.02.2023',
    'Halloween, 31.11.2023',
  ];

  final List<List<String>> presentsList = [
    ['Soft toy', 'Chocolate', 'Painting', 'Bracelet'],
    ['Candies', 'Cakes', 'Champagne'],
    ['Ring with topaz and diamonds', 'Telescope', 'Statuette', 'Plaid', 'Table lamp', 'Wine Bottle'],
  ];
  final List<List<String>> namesList = [
    ['Angela Miller', 'Young Robinson', 'Thomas Brown', 'Jessica Garcia'],
    ['Candies', 'Cakes', 'Champagne'],
    ['Thomas Brown', 'Stephen White', 'Angela Miller', 'Jessica Garcia', 'Young Robinson', 'Natalie Lewis'],
  ];
  final List<List<String>> starsList = [
    [SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars],
    [SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars],
    [SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars, SvgIcons.threeStars],
  ];

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<HolidayWithGiftsData>>(
      unionStateListenable: giftsState,
      builder: (_, gifts) {
        return AppGiftWidget(
          gifts: gifts,
          editGiftReceived: editGiftReceived,
          openAddGiftScreen: openAddGiftScreen,
        );
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
    );
  }
}
