import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
