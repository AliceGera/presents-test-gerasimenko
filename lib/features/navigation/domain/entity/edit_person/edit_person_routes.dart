import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';

/// All routes for the edit holiday feature.
final editPersonRoutes = AutoRoute(
  page: EditPersonRouter.page,
  path: AppRoutePaths.editPersonPath,
);
