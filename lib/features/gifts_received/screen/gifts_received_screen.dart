import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/gifts_received/screen/gifts_received_screen_wm.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for GiftsReceivedScreen feature.
@RoutePage(
  name: AppRouteNames.giftsReceivedScreen,
)
class GiftsReceivedScreen extends ElementaryWidget<IGiftsReceivedScreenWidgetModel> {
  /// Create an instance [GiftsReceivedScreen].
  const GiftsReceivedScreen({
    Key? key,
    WidgetModelFactory wmFactory = giftsReceivedScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGiftsReceivedScreenWidgetModel wm) {
    return ColoredBox(
      color: Colors.black,
      child: const Center(
        child: Text('Info screen view'),
      ),
    );
  }
}
