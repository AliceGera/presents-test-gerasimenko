import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/gifts_received/screen/gifts_received_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

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
      body: _Body(/*openNextScreen: wm.openNextScreen, editHolidayScreen: wm.editHolidayScreen*/),
    );
  }
}

class _Body extends StatelessWidget {
/*
  final VoidCallback openNextScreen;
  final VoidCallback editHolidayScreen;
*/

  _Body(/*{
    required this.openNextScreen,
    required this.editHolidayScreen,
  }*/
      );

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                separatorBuilder: (context, ind) => const SizedBox(height: 32),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, ind) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Dummy Card Text',
                        style: AppTextStyle.medium16.value.copyWith(color: AppColors.white),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: presentsList[ind].length,
                        itemBuilder: (context, index) => SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(color: AppColors.gray, height: 170, width: double.infinity),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SvgPicture.asset(SvgIcons.editGift),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(presentsList[ind][index],
                                  maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.bold14.value.copyWith(color: AppColors.white)),
                              const SizedBox(height: 4),
                              Text(namesList[ind][index],
                                  maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.regular13.value.copyWith(color: AppColors.white)),
                              const SizedBox(height: 8),
                              SvgPicture.asset(starsList[ind][index]),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(width: 7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: AppButtonWidget(
              title: 'Add a holiday +',
              //onPressed: openNextScreen,
            ),
          ),
        ],
      ),
    );
  }
}
