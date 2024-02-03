import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/news/screen/news_screen.dart';
import 'package:flutter_template/features/news/screen/news_screen_model.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [NewsScreenWidgetModel].
NewsScreenWidgetModel newsScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = NewsScreenModel(
    appDependencies.errorHandler,
  );
  final router = appDependencies.router;
  return NewsScreenWidgetModel(model, router);
}

/// Widget Model for [GiftsGivenScreen].
class NewsScreenWidgetModel extends WidgetModel<NewsScreen, NewsScreenModel> implements INewsScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [NewsScreenModel].
  NewsScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }
}

/// Interface of [NewsScreenWidgetModel].
abstract class INewsScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
}
