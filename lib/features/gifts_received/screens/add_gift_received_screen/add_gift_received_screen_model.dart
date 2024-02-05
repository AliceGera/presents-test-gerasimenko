import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';


/// Model for
class AddGiftReceivedScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  /// Create an instance [AddGiftReceivedScreenModel].
  AddGiftReceivedScreenModel(
    this.errorHandler,
  ) : super(errorHandler: errorHandler);
}
