import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';

final _datePickerConfig = CalendarDatePicker2WithActionButtonsConfig(
  calendarType: CalendarDatePicker2Type.single,
  weekdayLabels: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
  firstDayOfWeek: 1,
  weekdayLabelTextStyle: const TextStyle(
    color: Colors.grey,
    fontSize: 12,
  ),
  lastMonthIcon: const Icon(
    Icons.chevron_left,
    color: Colors.white,
  ),
  nextMonthIcon: const Icon(
    Icons.chevron_right,
    color: Colors.white,
  ),
  controlsTextStyle: const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  dayTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  ),
  selectedDayTextStyle: const TextStyle(
    color: AppColors.green,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  ),
  selectedDayHighlightColor: AppColors.green.withOpacity(0.1),
  yearTextStyle: const TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  ),
  selectedYearTextStyle: const TextStyle(
    color: AppColors.green,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
  cancelButtonTextStyle: const TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  okButtonTextStyle: const TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  closeDialogOnCancelTapped: true,
  centerAlignModePicker: true,
  openedFromDialog: true,
  gapBetweenCalendarAndButtons: 0,
);

List<DateTime?> _singleDatePickerValueWithDefaultValue = [DateTime.now()];

Future<List<DateTime?>?> showAppDatePicker(BuildContext context) async {
  return showCalendarDatePicker2Dialog(
    context: context,
    config: _datePickerConfig,
    dialogSize: const Size(325, 0),
    borderRadius: BorderRadius.circular(15),
    value: _singleDatePickerValueWithDefaultValue,
    dialogBackgroundColor: const Color(0xFF32313A),
  );
}
