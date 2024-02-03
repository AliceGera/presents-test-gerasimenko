import 'package:elementary/elementary.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Model for .
class SettingsScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;



  /// Create an instance [SettingsScreenModel].
  SettingsScreenModel(
    this.errorHandler,
  ) : super(errorHandler: errorHandler);

  @override
  void init() {
  }

  @override
  void dispose() {
  }



}
