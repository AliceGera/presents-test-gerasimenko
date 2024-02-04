import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/news/screen/news_screen_widget_model.dart';

/// News screen.
@RoutePage(
  name: AppRouteNames.newsScreen,
)
class NewsScreen extends ElementaryWidget<INewsScreenWidgetModel> {
  /// Create an instance [NewsScreen].
  const NewsScreen({
    Key? key,
    WidgetModelFactory wmFactory = newsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

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
      body: _Body(openNewsScreen: wm.openNewsScreen),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNewsScreen;

  const _Body({required this.openNewsScreen});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 11,
              itemBuilder: (context, index) => InkWell(
                onTap: openNewsScreen,
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
                            child: Image.asset('assets/images/image.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90,
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
                                  'The Art of Gift Giving: How to Choose the Perfect Present',
                                  style: AppTextStyle.regular14.value.copyWith(color: AppColors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '25.01.2024 • 5 minutes',
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
                  /*child: Image.network(
                  //subject['images']['large'],
                  height: 150.0,
                  width: 100.0,
                ),*/
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Column();
  }
}
