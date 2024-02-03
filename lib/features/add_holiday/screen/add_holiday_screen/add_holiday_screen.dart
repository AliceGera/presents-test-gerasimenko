import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/add_holiday/screen/add_holiday_screen/add_holiday_screen_widget_model.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.addHolidayScreen,
)
class AddHolidayScreen extends ElementaryWidget<IAddHolidayScreenWidgetModel> {
  /// Create an instance [AddHolidayScreen].
  const AddHolidayScreen({
    Key? key,
    WidgetModelFactory wmFactory = addHolidayScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAddHolidayScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Adding a holiday',
          style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
        ),
      ),
      body: _Body(closeScreen: wm.closeScreen),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback closeScreen;

  const _Body({required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12),
          _TextFieldWidget(
            text: 'Name of the holiday',
            //controller: wm.emailController,
            //formKey: wm.formEmailKey,
            //validatorText: wm.getEmailValidationTex,
          ),
          const SizedBox(height: 8),
          _TextFieldWidget(
            text: 'Date',
            //controller: wm.emailController,
            //formKey: wm.formEmailKey,
            //validatorText: wm.getEmailValidationTex,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(height: 90, width: 90, color: AppColors.textFieldBackground),
          ),
          Row(
            children: [
              Expanded(
                child: AppButtonWidget(
                  title: 'Cancel',
                  color: AppColors.white,
                  textColor: AppColors.black,
                  onPressed: closeScreen,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: AppButtonWidget(
                  title: 'Save',
                  //onPressed: openNextScreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TextFieldWidget extends StatefulWidget {
  _TextFieldWidget({
    required this.text,
    // required this.formKey,
    // required this.controller,
    this.validatorText,
  });

  //final TextEditingController controller;
  //final GlobalKey<FormState> formKey;
  final String text;
  final String? Function()? validatorText;
  String? _currentValidationText;

  @override
  State<_TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<_TextFieldWidget> {
  _TextFieldWidgetState();

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: widget.formKey,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                setState(() {
                  widget._currentValidationText = widget.validatorText?.call();
                });
                return '';
              },
              //controller: widget.controller,
              decoration: InputDecoration(
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
                labelText: widget.text,
                labelStyle: const TextStyle(color: AppColors.white),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
