import 'package:flutter/material.dart';
import 'package:flutter_template/assets/text/text_style.dart';

/// App text style scheme.
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  /// Text style 12_133.
  final TextStyle regular12;

  /// Text style 13_138.
  final TextStyle regular13;

  /// Text style 14_140.
  final TextStyle regular14;

  /// Text style 16_124.
  final TextStyle regular16;

  /// Text style 11_118_500.
  final TextStyle medium11;

  /// Text style 14_140_500.
  final TextStyle medium14;

  /// Text style 16_124_500.
  final TextStyle medium16;

  /// Text style 17_129_600.
  final TextStyle semiBold17;

  /// Text style 14_140_700.
  final TextStyle bold14;

  /// Text style 16_124_700.
  final TextStyle bold16;

  /// Text style 19_137_700.
  final TextStyle bold19;

  AppTextTheme._({
    required this.regular12,
    required this.regular13,
    required this.regular14,
    required this.regular16,
    required this.medium11,
    required this.medium14,
    required this.medium16,
    required this.semiBold17,
    required this.bold14,
    required this.bold16,
    required this.bold19,
  });

  /// Base app text theme.
  AppTextTheme.base()
      : regular12 = AppTextStyle.regular12.value,
        regular13 = AppTextStyle.regular13.value,
        regular14 = AppTextStyle.regular14.value,
        regular16 = AppTextStyle.regular16.value,
        medium11 = AppTextStyle.medium11.value,
        medium14 = AppTextStyle.medium14.value,
        medium16 = AppTextStyle.medium16.value,
        bold14 = AppTextStyle.bold14.value,
        semiBold17= AppTextStyle.semiBold17.value,
        bold16 = AppTextStyle.bold16.value,
        bold19 = AppTextStyle.bold19.value;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      regular12: TextStyle.lerp(regular12, other.regular12, t)!,
      regular13: TextStyle.lerp(regular13, other.regular13, t)!,
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      medium11: TextStyle.lerp(medium11, other.medium11, t)!,
      medium14: TextStyle.lerp(medium14, other.medium14, t)!,
      medium16: TextStyle.lerp(medium16, other.medium16, t)!,
      semiBold17: TextStyle.lerp(semiBold17, other.semiBold17, t)!,
      bold14: TextStyle.lerp(bold14, other.bold14, t)!,
      bold16: TextStyle.lerp(bold16, other.bold16, t)!,
      bold19: TextStyle.lerp(bold19, other.bold19, t)!,
    );
  }

  /// Return text theme for app from context.
  static AppTextTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextTheme>() ?? _throwThemeExceptionFromFunc(context);
  }

  /// @nodoc.
  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? regular12,
    TextStyle? regular13,
    TextStyle? regular14,
    TextStyle? regular16,
    TextStyle? medium11,
    TextStyle? medium14,
    TextStyle? medium16,
    TextStyle? semiBold17,
    TextStyle? bold14,
    TextStyle? bold16,
    TextStyle? bold19,
  }) {
    return AppTextTheme._(
      regular12: regular12 ?? this.regular12,
      regular13: regular13 ?? this.regular13,
      regular14: regular14 ?? this.regular14,
      regular16: regular16 ?? this.regular16,
      medium11: medium11 ?? this.medium11,
      medium14: medium14 ?? this.medium14,
      medium16: medium16 ?? this.medium16,
      semiBold17: semiBold17 ?? this.semiBold17,
      bold14: bold14 ?? this.bold14,
      bold16: bold16 ?? this.bold16,
      bold19: bold16 ?? this.bold19,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppTextTheme не найдена в $context');
