import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/gifts_given/screens/edit_gift_given_screen/edit_gift_given_screen.dart';
import 'package:flutter_template/features/gifts_given/screens/edit_gift_given_screen/edit_gift_given_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for
EditGiftGivenScreenWidgetModel editGiftGivenScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = EditGiftGivenScreenModel(
    appDependencies.errorHandler,
    appScope.giftsService,
    appScope.holidaysService,
  );
  final router = appDependencies.router;
  return EditGiftGivenScreenWidgetModel(model, router);
}

/// Widget Model for [EditGiftGivenScreenWidgetModel].
class EditGiftGivenScreenWidgetModel extends WidgetModel<EditGiftGivenScreen, EditGiftGivenScreenModel> implements IEditGiftGivenScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [EditGiftGivenScreenModel].
  EditGiftGivenScreenWidgetModel(
    super._model,
    this.router,
  );

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _giftNameController = TextEditingController();
  final TextEditingController _giftPriceController = TextEditingController();

  final ValueNotifier<Gift> _giftState = ValueNotifier<Gift>(Gift.init());
  void Function(Holiday)? _updateHoliday;
  final _personMessageState = ValueNotifier<String?>(null);
  final _holidayNameMessageState = ValueNotifier<String?>(null);

  final GlobalKey<FormState> _formGiftNameKey = GlobalKey<FormState>();

  String? _holidayNameValidationText;
  String? _personValidationText;
  String? _giftNameValidationText;

  @override
  void dispose() {
    _commentController.removeListener(_commentListener);
    _giftNameController.removeListener(_giftListener);
    _giftPriceController.removeListener(_giftPriceListener);
    _commentController.dispose();
    _giftNameController.dispose();
    _giftPriceController.dispose();
    super.dispose();
  }

  void _commentListener() {
    model.giftComment = _commentController.text;
  }

  void _giftListener() {
    model.giftName = _giftNameController.text;
    if (_giftNameValidationText != null) {
      _giftNameValidationText = null;
      _formGiftNameKey.currentState?.validate();
    }
  }

  void _giftPriceListener() {
    model.giftPrice = _giftPriceController.text;
  }

  @override
  void initWidgetModel() {
    final args = router.current.args as EditGiftGivenRouterArgs?;

    _commentController.addListener(_commentListener);
    _giftNameController.addListener(_giftListener);
    _giftPriceController.addListener(_giftPriceListener);

    if (args != null) {
      model
        ..gift = args.gift
        ..holidayName = args.holiday.holidayName
        ..holidayId = args.holiday.id;
      _commentController.text = args.gift.giftComment;
      _giftNameController.text = args.gift.giftName;
      _giftPriceController.text = args.gift.giftPrice;
      _giftState.value = model.gift;
      _updateHoliday = args.updateHoliday;
    }

    super.initWidgetModel();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  Future<void> choosePersonOnTap() async {
    final result = await router.push(
      PersonRouter(
        updatePerson: (selectedPerson) async {
          if (selectedPerson.id == model.gift.whoGaveId) {
            model
              ..whoGave = '${selectedPerson.firstName} ${selectedPerson.lastName}'
              ..whoGaveId = selectedPerson.id;
            _giftState.value = model.gift;
          }
        },
        deletePerson: (selectedPerson) async {
          if (selectedPerson.id == model.gift.whoGaveId) {
            model
              ..whoGave = ''
              ..whoGaveId = 0;
            _giftState.value = model.gift;
          }
        },
      ),
    );
    if (result is Person) {
      model
        ..whoGave = '${result.firstName} ${result.lastName}'
        ..whoGaveId = result.id;
      _giftState.value = model.gift;
      _personMessageState.value = null;
    }
  }

  @override
  Future<void> chooseHolidayNameOnTap() async {
    final result = await router.push(
      HolidayNameRouter(
        updateHoliday: (selectedHoliday) async {
          if (selectedHoliday.id == model.holidayId) {
            final holidays = await model.getHolidays();
            final newHoliday = holidays.firstWhere((element) => element.id == selectedHoliday.id);
            model.holidayName = newHoliday.holidayName;
            _giftState.value = model.gift;
            _updateHoliday?.call(newHoliday);
          }
        },
      ),
    );
    if (result is Holiday) {
      model
        ..holidayName = result.holidayName
        ..holidayId = result.id;
      _giftState.value = model.gift;
      _holidayNameMessageState.value = null;
    }
  }

  @override
  Future<void> editGiftOnTap() async {
    final isGiftNameCorrect = _giftNameController.text.isNotEmpty;
    if (!isGiftNameCorrect) {
      _giftNameValidationText = 'error';
      _formGiftNameKey.currentState?.validate();
    }
    final isPersonCorrect = _giftState.value.whoGave.isNotEmpty;
    if (!isPersonCorrect) {
      _personMessageState.value = 'error';
    }
    final isHolidayNameCorrect = _giftState.value.holidayName != null;
    if (!isHolidayNameCorrect) {
      _holidayNameMessageState.value = 'error';
    }
    if (isGiftNameCorrect && isPersonCorrect && isHolidayNameCorrect) {
      await model.editGift();
      await router.pop();
    }
  }

  @override
  Future<void> deleteGift() async {
    await model.deleteGift();
    await router.pop();
  }

  @override
  Future<void> rateOnTap(int rate) async {
    model.giftRate = rate;
    _giftState.value = model.gift;
  }

  @override
  TextEditingController get giftNameController => _giftNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  TextEditingController get giftPriceController => _giftPriceController;

  @override
  ValueNotifier<Gift> get giftState => _giftState;

  @override
  String? getHolidayNameValidationText() => _holidayNameValidationText;

  @override
  String? getPersonValidationText() => _personValidationText;

  @override
  String? getGiftNameValidationText() => _giftNameValidationText;

  @override
  ValueNotifier<String?> get personMessageState => _personMessageState;

  @override
  ValueNotifier<String?> get holidayNameMessageState => _holidayNameMessageState;

  @override
  GlobalKey<FormState> get formGiftNameKey => _formGiftNameKey;
}

/// Interface of [EditGiftGivenScreenWidgetModel].
abstract class IEditGiftGivenScreenWidgetModel implements IWidgetModel {
  /// Method to close screen.
  void closeScreen() {}

  /// Method to choose person.
  void choosePersonOnTap() {}

  /// Method to choose holiday name.
  void chooseHolidayNameOnTap() {}

  /// Method to edit Gift.
  Future<void> editGiftOnTap();

  /// Method to delete Gift.
  Future<void> deleteGift();

  /// Method to save rate.
  void rateOnTap(int rate);

  /// Method to save photo.
  void savePhoto(Uint8List photo);

  /// Method get gift name controller for gift name field.
  TextEditingController get giftNameController;

  /// Method get comment controller for comment field.
  TextEditingController get commentController;

  /// Method get price controller for price field.
  TextEditingController get giftPriceController;

  ///Method get gift state.
  ValueNotifier<Gift> get giftState;

  ValueNotifier<String?> get personMessageState;

  ValueNotifier<String?> get holidayNameMessageState;

  /// Method get formKey for holiday name field
  GlobalKey<FormState> get formGiftNameKey;

  String? getHolidayNameValidationText();

  String? getPersonValidationText();

  String? getGiftNameValidationText();
}
