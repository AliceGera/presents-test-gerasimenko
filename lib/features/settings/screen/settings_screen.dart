import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/settings/screen/settings_screen_widget_model.dart';

/// News screen.
@RoutePage(
  name: AppRouteNames.settingsScreen,
)
class SettingsScreen extends ElementaryWidget<ISettingsScreenWidgetModel> {
  /// Create an instance [SettingsScreen].
  const SettingsScreen({
    Key? key,
    WidgetModelFactory wmFactory = settingsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsScreenWidgetModel wm) {
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
        child: Column(),
      ),
    );
  }
}
