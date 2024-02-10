import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';

class AppBottomSheet extends StatefulWidget {
  final Widget content;
  final VoidCallback initWidgetModel;

  const AppBottomSheet({
    super.key,
    required this.content,
    required this.initWidgetModel,
  });

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  void initState() {
    widget.initWidgetModel.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: ColoredBox(
          color: AppColors.backgroundColor,
          child: widget.content,
        ),
      ),
    );
  }
}
