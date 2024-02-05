import 'package:flutter/material.dart';

import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class AppTextFieldWidget extends StatefulWidget {
  AppTextFieldWidget({
    super.key,
    required this.text,
    // required this.formKey,
    required this.controller,
    this.validatorText,
    this.lines = 1,
  });

  final TextEditingController controller;
  final int lines;

  //final GlobalKey<FormState> formKey;
  final String text;
  final String? Function()? validatorText;
  String? _currentValidationText;

  @override
  State<AppTextFieldWidget> createState() => _AppTextFieldWidgetState();
}

class _AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  final FocusNode _focus = FocusNode();

  bool isFocused = false;
  bool isShowFloatingLabel = false;

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus
      ..removeListener(_onFocusChange)
      ..dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: widget.formKey,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.controller.value.text.isNotEmpty || _focus.hasFocus
                ? Text(
                    widget.text,
                    style: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
                  )
                : SizedBox(),
            TextFormField(
              maxLines: widget.lines,
              style: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
              validator: (value) {
                setState(() {
                  widget._currentValidationText = widget.validatorText?.call();
                });
                return '';
              },
              focusNode: _focus,
              controller: widget.controller,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: AppColors.textFieldBackground),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: AppColors.textFieldBackground),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.textFieldBackground, width: 0),
                ),
                fillColor: AppColors.textFieldBackground,
                filled: true,
                hintText: widget.text,
                hintStyle: AppTextStyle.regular13.value.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
