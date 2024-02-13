import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/features/app/app.dart';
import 'package:flutter_template/features/app/di/app_scope_register.dart';

/// App launch.
Future<void> run() async {
  /// It must be called so that the orientation does not fall.
  WidgetsFlutterBinding.ensureInitialized();

  /// Fix orientation.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await _runApp();
}

Future<void> _runApp() async {
  final scopeRegister = AppScopeRegister();
  final scope = await scopeRegister.createScope();
  runApp(App(scope));
}
