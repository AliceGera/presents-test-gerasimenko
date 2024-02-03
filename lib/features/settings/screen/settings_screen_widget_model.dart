import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/news/screen/news_screen_model.dart';
import 'package:flutter_template/features/settings/screen/settings_screen.dart';
import 'package:flutter_template/features/settings/screen/settings_screen_model.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [SettingsScreenWidgetModel].
SettingsScreenWidgetModel settingsScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = SettingsScreenModel(
    appDependencies.errorHandler,
  );
  final router = appDependencies.router;
  return SettingsScreenWidgetModel(model, router);
}

/// Widget Model for [GiftsGivenScreen].
class SettingsScreenWidgetModel extends WidgetModel<SettingsScreen, SettingsScreenModel> implements ISettingsScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [NewsScreenModel].
  SettingsScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  void closeScreen() {
    router.pop();
  }
}

/// Interface of [SettingsScreenWidgetModel].
abstract class ISettingsScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
}
