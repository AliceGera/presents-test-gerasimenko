import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_export.dart';
import 'package:flutter_template/features/gifts_received/screen/gifts_received_screen_export.dart';
import 'package:flutter_template/features/holidays/screen/holidays_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/add_holiday/add_holiday_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/temp/temp_routes.dart';
import 'package:flutter_template/features/news/screen/news_screen_export.dart';
import 'package:flutter_template/features/add_holiday/screen/add_holiday_screen/add_holiday_screen_export.dart';
import 'package:flutter_template/features/settings/screen/settings_screen_export.dart';
import 'package:flutter_template/features/temp/screens/temp_screen/temp_screen_export.dart';

part 'router.gr.dart';

/// When you add route with screen don't forget add imports of screen and screen_widget_model

@AutoRouterConfig(
  replaceInRouteName: 'ScreenWidget|Screen,Route',
)

/// Main point of the application navigation.
class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        tempRoutes,
        addHolidayRoutes,
      ];

  AppRouter._();

  /// Singleton instance of [AppRouter].
  factory AppRouter.instance() => _router;
}
