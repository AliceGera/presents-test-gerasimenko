import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/settings/screen/settings_screen.dart';
import 'package:flutter_template/features/settings/screen/settings_screen_model.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// Create an instance [SettingsScreenModel].
  SettingsScreenWidgetModel(
    super._model,
    this.router,
  );

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> onTap() async {
    const url = 'https://flutter.dev';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Future<void> onTapAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}

/// Interface of [SettingsScreenWidgetModel].
abstract class ISettingsScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  void onTap() {}

  void onTapAppReview() {}
}
