/// List of all the paths that are used to navigate in temp feature.
///
/// Have to been filled with the entries like this:
/// ```dart
/// /// Path description.
/// static const String screenPath = 'screenPath';
/// ```
abstract class AppRoutePaths {
  /// Path to temp screen.
  static const String tempPath = '/temp';

  /// Path to gifts given screen.
  static const String giftsGivenPath = 'gifts_given';

  /// Path to ui kit screen.
  static const String uiKitPath = '/ui_kit';

  /// Path to holidays screen.
  static const String holidaysPath = 'holidays';

  /// Path to gifts received screen.
  static const String giftsReceivedPath = 'gifts_received';

  /// Path to news screen.
  static const String newsPath = 'news';

  /// Path to settings screen.
  static const String settingsPath = 'settings';

  /// Path to holidays screen.
  static const String addHolidayPath = '/addHoliday';

  /// Path to logs history screen.
  static const String logHistory = '/logHistory';
}
