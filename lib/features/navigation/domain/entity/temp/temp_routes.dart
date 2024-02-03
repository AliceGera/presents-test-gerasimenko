import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/domain/entity/gifts_given/gifts_given_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/gifts_received/gifts_received_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/holidays/dash_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/news/news_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/settings/settings_routes.dart';
import 'package:flutter_template/features/navigation/service/router.dart';

/// All routes for the temp feature.
final tempRoutes = AutoRoute(
  page: TempRouter.page,
  initial: true,
  path: AppRoutePaths.tempPath,
  children: [
    holidaysRoutes,
    giftsReceivedRoutes,
    giftsGivenRoutes,
    newsRoutes,
    settingsRoutes,
  ],
);
