import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Model for [GiftsGivenScreen].
class GiftsGivenScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  /// Create an instance [GiftsGivenScreenModel].
  GiftsGivenScreenModel(
    this.errorHandler,
  ) : super(errorHandler: errorHandler);

  @override
  void init() {}

  @override
  void dispose() {}
}
