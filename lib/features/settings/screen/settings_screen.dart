import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/settings/screen/settings_screen_widget_model.dart';

/// News screen.
@RoutePage(
  name: AppRouteNames.settingsScreen,
)
class SettingsScreen extends ElementaryWidget<ISettingsScreenWidgetModel> {
  /// Create an instance [SettingsScreen].
  const SettingsScreen({
    Key? key,
    WidgetModelFactory wmFactory = settingsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Settings',
          style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
        ),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.darkBlue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgIcons.privacy),
                          const SizedBox(width: 16),
                          Text('Privacy policy', style: AppTextStyle.regular14.value.copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.gray),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgIcons.userAgreement),
                          const SizedBox(width: 16),
                          Text('User agreement', style: AppTextStyle.regular14.value.copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.gray),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgIcons.rateApp),
                          const SizedBox(width: 16),
                          Text('Rate the app', style: AppTextStyle.regular14.value.copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
