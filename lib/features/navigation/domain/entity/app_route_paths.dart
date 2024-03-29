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

  /// Path to add gift given screen.
  static const String addGiftGivenPath = '/add_gift_given';

  /// Path to edit gift given screen.
  static const String editGiftGivenPath = '/edit_gift_given';

  /// Path to holidays screen.
  static const String holidaysPath = 'holidays';

  /// Path to gifts received screen.
  static const String giftsReceivedPath = 'gifts_received';

  /// Path to add gift received screen.
  static const String addGiftReceivedPath = '/add_gift_received';

  /// Path to edit gift received screen.
  static const String editGiftReceivedPath = '/edit_gift_received';

  /// Path to news screen.
  static const String newsPath = 'news';

  /// Path to read news screen.
  static const String readNewsPath = '/readNews';

  /// Path to settings screen.
  static const String settingsPath = 'settings';

  /// Path to holidays screen.
  static const String addHolidayPath = '/addHoliday';

  /// Path to edit holiday screen.
  static const String editHolidayPath = '/editHoliday';

  /// Path to who gave present screen.
  static const String personPath = '/person';

  /// Path to holiday name Screen.
  static const String holidayNamePath = '/holidayNamePresent';

  /// Path to edit person screen.
  static const String editPersonPath = '/editPerson';

  /// Path to  holiday gifts screen.
  static const String holidayGiftsPath = '/holidayGifts';
}
