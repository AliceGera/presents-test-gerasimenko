import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [GiftsGivenScreenWidgetModel].
GiftsGivenScreenWidgetModel giftsGivenScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = GiftsGivenScreenModel(
    appDependencies.errorHandler,
  );
  final router = appDependencies.router;
  return GiftsGivenScreenWidgetModel(model, router);
}

/// Widget Model for [GiftsGivenScreen].
class GiftsGivenScreenWidgetModel extends WidgetModel<GiftsGivenScreen, GiftsGivenScreenModel> implements IGiftsGivenScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [GiftsGivenScreenModel].
  GiftsGivenScreenWidgetModel(
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

/// Interface of [GiftsGivenScreenWidgetModel].
abstract class IGiftsGivenScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
}
