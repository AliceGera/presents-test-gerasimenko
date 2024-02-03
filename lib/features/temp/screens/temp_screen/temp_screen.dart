import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/temp/screens/temp_screen/temp_screen_widget_model.dart';

/// Initialization screens (this can be a HomeScreen or SplashScreen for example).
@RoutePage(
  name: AppRouteNames.tempScreen,
)
class TempScreen extends ElementaryWidget<TempScreenWidgetModel> {
  /// Create an instance [TempScreen].
  const TempScreen({
    Key? key,
    WidgetModelFactory wmFactory = initScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(TempScreenWidgetModel wm) {
    return AutoTabsRouter.tabBar(
        routes: wm.routes,
        builder: (context, child, controller) {
          final tabsRouter = context.tabsRouter;
          return Scaffold(
            backgroundColor:  AppColors.backgroundColor,
            body: child,
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                selectedFontSize: 11,
                unselectedFontSize: 11,
                enableFeedback: false,
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xff131849),
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: wm.navigationBarItems,
                unselectedItemColor: const Color(0xff838383),
                selectedItemColor: const Color(0xff3ECDBA),
                showUnselectedLabels: true,
                mouseCursor: SystemMouseCursors.none,
              ),
            ),
          );
        });
  }
}
