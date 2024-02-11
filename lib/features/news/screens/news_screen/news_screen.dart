import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

import 'package:flutter_template/features/news/screens/news_screen/news_screen_widget_model.dart';

/// News screen.
@RoutePage(
  name: AppRouteNames.newsScreen,
)
class NewsScreen extends ElementaryWidget<INewsScreenWidgetModel> {
  /// Create an instance [NewsScreen].
  NewsScreen({
    Key? key,
    WidgetModelFactory wmFactory = newsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);
  List<String> images = [
    'assets/images/balls.png',
    'assets/images/image.png',
    'assets/images/dog.png',
    'assets/images/shirts.png',
    'assets/images/social_media.png',
  ];
  List<String> title = [
    'The Art of Gift Giving: How to Choose the Perfect Present',
    'Exquisite Mementos: The 12 Best Gifts from Dubai',
    'Top 30 Gifts for Your Pet: Show Your Furry Friend Some Love',
    '6 Attainable Ways to Craft Your Custom T-shirt & Apparel',
    'Social Medias Impact on Gift-giving and Generosity',
  ];
  List<String> date = [
    '01.11.2024',
    '17.01.2024',
    '02.05.2024',
    '18.01.2024',
    '15.01.2024',
  ];
  List<String> time = [
    '4 minutes',
    '12 minutes',
    '7 minutes',
    '10 minutes',
    '6 minutes',
  ];

  @override
  Widget build(INewsScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            'News',
            style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: title.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: wm.openNewsScreen,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: SizedBox(
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset(images[index]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.darkBlue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title[index],
                                    style: AppTextStyle.regular14.value.copyWith(color: AppColors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      '${date[index]} ${time[index]}',
                                      style: AppTextStyle.regular12.value.copyWith(color: AppColors.lightGray),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
