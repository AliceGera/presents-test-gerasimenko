import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/temp/screens/temp_screen/temp_screen.dart';
import 'package:flutter_template/features/temp/screens/temp_screen/temp_screen_model.dart';

/// Factory for [TempScreenWidgetModel].
TempScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = TempScreenModel();

  return TempScreenWidgetModel(model);
}

/// Widget model for [TempScreen].
class TempScreenWidgetModel extends WidgetModel<TempScreen, ITempScreenModel> with ThemeWMMixin implements ITempScreenWidgetModel {
  final _defaultNavBarItems = [
    BottomNavigationBarItem(
      label: 'Holidays',
      icon: SvgPicture.asset(SvgIcons.balls),
      activeIcon: SvgPicture.asset(SvgIcons.activeBalls),
    ),
    BottomNavigationBarItem(
      label: 'Gifts received',
      icon: SvgPicture.asset(SvgIcons.giftsReceived),
      activeIcon: SvgPicture.asset(SvgIcons.activeGiftsReceived),
    ),
    BottomNavigationBarItem(
      label: 'Gifts given',
      icon: SvgPicture.asset(SvgIcons.giftsGiven),
      activeIcon: SvgPicture.asset(SvgIcons.activeGiftsGiven),
    ),
    BottomNavigationBarItem(
      label: 'news',
      icon: SvgPicture.asset(SvgIcons.news),
      activeIcon: SvgPicture.asset(SvgIcons.activeNews, color: Color(0xff30BEAB)),
    ),
    BottomNavigationBarItem(
      label: 'Settings',
      icon: SvgPicture.asset(SvgIcons.settings),
      activeIcon: SvgPicture.asset(SvgIcons.activeSettings),
    ),
  ];

  @override
  List<PageRouteInfo> get routes => _routes;

  @override
  List<BottomNavigationBarItem> get navigationBarItems => _navigationBarItems;

  List<PageRouteInfo> get _routes {
    final defaultRoutes = <PageRouteInfo>[HolidaysRouter(), GiftsReceivedRouter(), NewsRouter(), SettingsRouter(), GiftsGivenRouter()];

    return defaultRoutes;
  }

  List<BottomNavigationBarItem> get _navigationBarItems {
    final navBarItems = [..._defaultNavBarItems];
    return navBarItems;
  }

  /// Create an instance [TempScreenWidgetModel].
  TempScreenWidgetModel(super._model);

  @override
  String appBarTitle(RouteData topRoute) => _appBarTitle(topRoute);

  String _appBarTitle(RouteData topRoute) {
    switch (topRoute.path) {
      case AppRoutePaths.giftsGivenPath:
        return 'Экран отладки';
      case AppRoutePaths.holidaysPath:
        return 'Dash';
      case AppRoutePaths.giftsReceivedPath:
        return 'Info';
      case AppRoutePaths.newsPath:
        return 'Info';
      case AppRoutePaths.settingsPath:
        return 'Info';
      default:
        return '';
    }
  }
}

/// Interface of [TempScreenWidgetModel].
abstract class ITempScreenWidgetModel implements IWidgetModel {
  /// Routes for [AutoTabsRouter.tabBar].
  List<PageRouteInfo<dynamic>> get routes;

  /// Items for [BottomNavigationBar].
  List<BottomNavigationBarItem> get navigationBarItems;

  /// Title for appbar, depends on current selected page.
  String appBarTitle(RouteData topRoute);
}
