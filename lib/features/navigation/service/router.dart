import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/gifts_given/screens/add_gift_given_screen/add_gift_given_screen_export.dart';
import 'package:flutter_template/features/gifts_given/screens/edit_gift_given_screen/edit_gift_given_screen_export.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_export.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen_export.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen_export.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen_export.dart';
import 'package:flutter_template/features/holiday_selection_screen/holiday_selection_screen_export.dart';
import 'package:flutter_template/features/holidays/screens/add_holiday_screen/add_holiday_screen_export.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_export.dart';
import 'package:flutter_template/features/holidays/screens/holiday_gifts_screen/holiday_gifts_screen_export.dart';
import 'package:flutter_template/features/holidays/screens/holidays_screen/holidays_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/add_gift_given/add_gift_given_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/add_gift_received/add_gift_received_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/add_holiday/add_holiday_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/edit_gift_given/edit_gift_given_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/edit_gift_received/edit_gift_received_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/edit_holiday/edit_holiday_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/edit_person/edit_person_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/holiday_gifts/holiday_gifts_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/holiday_name/holiday_name_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/person/person_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/read_news/read_news_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/temp/temp_routes.dart';
import 'package:flutter_template/features/news/screens/news_screen/news_screen_export.dart';
import 'package:flutter_template/features/news/screens/read_news_screen/read_news_screen_export.dart';
import 'package:flutter_template/features/person_screen/screens/edit_person_screen/edit_person_screen_export.dart';
import 'package:flutter_template/features/person_screen/screens/person_screen/person_screen_export.dart';
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
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        tempRoutes,
        addHolidayRoutes,
        editHolidayRoutes,
        readNewsRoutes,
        addGiftReceivedRoutes,
        editGiftReceivedRoutes,
        whoPersonRoutes,
        holidayNameRoutes,
        editPersonRoutes,
        holidayGiftsRoutes,
        addGiftGivenRoutes,
        editGiftGivenRoutes,
      ];

  AppRouter._();

  /// Singleton instance of [AppRouter].
  factory AppRouter.instance() => _router;
}
