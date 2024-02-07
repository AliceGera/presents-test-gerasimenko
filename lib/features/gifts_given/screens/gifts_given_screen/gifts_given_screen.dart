import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_gifts_widget.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.giftsGivenScreen,
)
class GiftsGivenScreen extends ElementaryWidget<IGiftsGivenScreenWidgetModel> {
  /// Create an instance [GiftsGivenScreen].
  const GiftsGivenScreen({
    Key? key,
    WidgetModelFactory wmFactory = giftsGivenScreenWidgetModelFactory,
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
      body: _Body(openAddGiftScreen: () {}, editGiftReceived: () {}),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openAddGiftScreen;
  final VoidCallback editGiftReceived;

  _Body({
    required this.openAddGiftScreen,
    required this.editGiftReceived,
  });

  final List<String> holidaysList = ['Saint Valentine’s Day, 14.02.2023', 'Halloween, 31.11.2023'];
  final List<List<String>> presentsList = [
    ['Necklace', 'Statuette', 'Book'],
    ['Wine', 'Chocolate', 'Marmalade'],
  ];
  final List<List<String>> namesList = [
    ['Angela Miller', 'Young Robinson', 'Thomas Brown'],
    ['Candies', 'Cakes', 'Champagne'],
  ];
  final List<List<String>> starsList = [
    ['420', '1 200', '1 400'],
    ['420', '1 200', '1 400'],
  ];

  @override
  Widget build(BuildContext context) {
    return AppGiftWidget(
      editGiftReceived: editGiftReceived,
      openAddGiftScreen: openAddGiftScreen,
      gifts: [],
    );
  }
}
