import 'package:flutter/foundation.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/config/environment/build_types.dart';

/// Environment configuration.
class Environment implements Listenable {
  static Environment? _instance;

  /// Firebase options for initialize.

  final BuildType _currentBuildType;

  /// Configuration.
  AppConfig get config => _config.value;

  set config(AppConfig c) => _config.value = c;

  /// Is this application running in debug mode.
  bool get isDebug => _currentBuildType == BuildType.debug;

  /// Is this application running in release mode.
  bool get isRelease => _currentBuildType == BuildType.release;

  /// App build type.
  BuildType get buildType => _currentBuildType;

  ValueNotifier<AppConfig> _config;

  Environment._(
    this._currentBuildType,
    AppConfig config,
  ) : _config = ValueNotifier<AppConfig>(config);

  /// Provides instance [Environment].
  factory Environment.instance() => _instance!;

  @override
  void addListener(VoidCallback listener) {
    _config.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _config.removeListener(listener);
  }

  /// Initializing the environment.
  static void init({
    required BuildType buildType,
    required AppConfig config,
  }) {
    _instance ??= Environment._(
      buildType,
      config,
    );
  }
}
