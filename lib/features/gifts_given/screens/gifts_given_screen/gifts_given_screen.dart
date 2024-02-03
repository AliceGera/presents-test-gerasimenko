import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/urls.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.giftsGivenScreen,
)
class GiftsGivenScreen extends ElementaryWidget<IGiftsGivenScreenWidgetModel> {
  /// Create an instance [GiftsGivenScreen].
  const GiftsGivenScreen({
    Key? key,
    WidgetModelFactory wmFactory = giftsGivenScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGiftsGivenScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
