import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/assets/themes/theme_data.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/widgets/di_scope/di_scope.dart';

/// App widget.
class App extends StatefulWidget {
  /// Scope of dependencies which need through all app's life.
  final AppScope appScope;

  /// Create an instance App.
  const App(this.appScope, {super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    super.initState();

    _scope = widget.appScope..applicationRebuilder = _rebuildApplication;
  }

  void _rebuildApplication() {
    setState(() {
      _scope = widget.appScope..applicationRebuilder = _rebuildApplication;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: MaterialApp.router(
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,

        /// Localization.
        locale: _localizations.first,
        localizationsDelegates: _localizationsDelegates,
        supportedLocales: _localizations,

        /// This is for navigation.
        routeInformationParser: _scope.router.defaultRouteParser(),
        routerDelegate: _scope.router.delegate(),
      ),
    );
  }
}

const _localizations = [
  Locale('ru', 'RU'),
];

const _localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
