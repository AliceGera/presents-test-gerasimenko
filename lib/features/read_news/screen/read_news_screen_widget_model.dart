import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/read_news/screen/read_news_screen.dart';
import 'package:flutter_template/features/read_news/screen/read_news_screen_model.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [ReadNewsScreenWidgetModel].
ReadNewsScreenWidgetModel readNewsScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = ReadNewsScreenModel(
    appDependencies.errorHandler,
  );
  final router = appDependencies.router;
  return ReadNewsScreenWidgetModel(model, router);
}

/// Widget Model for [GiftsGivenScreen].
class ReadNewsScreenWidgetModel extends WidgetModel<ReadNewsScreen, ReadNewsScreenModel> implements IReadNewsScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [ReadNewsScreenModel].
  ReadNewsScreenWidgetModel(
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

  @override
  void openNewsScreen() {
    router.push(AddHolidayRouter());
  }
}

/// Interface of [ReadNewsScreenWidgetModel].
abstract class IReadNewsScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Navigate to room screen.
  void openNewsScreen();
}
