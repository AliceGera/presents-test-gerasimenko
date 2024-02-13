import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/gifts_given/screens/add_gift_given_screen/add_gift_given_screen.dart';
import 'package:flutter_template/features/gifts_given/screens/add_gift_given_screen/add_gift_given_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [AddGiftGivenScreenWidgetModel].
AddGiftGivenScreenWidgetModel addGiftGivenScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = AddGiftGivenScreenModel(
    appDependencies.errorHandler,
    appScope.giftsService,
    appScope.holidaysService,
  );
  final router = appDependencies.router;
  return AddGiftGivenScreenWidgetModel(model, router);
}

/// Widget Model for [AddGiftGivenScreen].
class AddGiftGivenScreenWidgetModel extends WidgetModel<AddGiftGivenScreen, AddGiftGivenScreenModel> implements IAddGiftGivenScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [AddGiftGivenScreenModel].
  AddGiftGivenScreenWidgetModel(
    super._model,
    this.router,
  );

  final _giftsState = UnionStateNotifier<Gift>(Gift.init());
  final _holidayNameState = ValueNotifier<String?>(null);
  final _personState = ValueNotifier<String?>(null);
  final TextEditingController _giftNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _personMessageState = ValueNotifier<String?>(null);
  final _holidayNameMessageState = ValueNotifier<String?>(null);

  final GlobalKey<FormState> _formGiftNameKey = GlobalKey<FormState>();

  String? _holidayNameValidationText;
  String? _personValidationText;
  String? _giftNameValidationText;

  @override
  void initWidgetModel() {
    _giftNameController.addListener(() {
      if (_giftNameValidationText != null) {
        _giftNameValidationText = null;
        _formGiftNameKey.currentState?.validate();
      }
      model.giftName = _giftNameController.text;
    });
    _commentController.addListener(() {
      model.giftComment = _commentController.text;
    });
    _priceController.addListener(() {
      model.giftPrice = _priceController.text;
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _giftNameController.dispose();
    _commentController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> choosePersonScreenOnTap() async {
    final result = await router.push(
      PersonRouter(
        updatePerson: (selectedPerson) async {
          if (selectedPerson.id == model.gift.whoGaveId) {
            model
              ..whoGavePresent = '${selectedPerson.firstName} ${selectedPerson.lastName}'
              ..whoGaveId = selectedPerson.id;
            _personState.value = model.whoGavePresent;
          }
        },
        deletePerson: (selectedPerson) async {
          if (selectedPerson.id == model.gift.whoGaveId) {
            model
              ..whoGavePresent = ''
              ..whoGaveId = 0;
            _personState.value = model.whoGavePresent;
          }
        },
      ),
    );
    if (result is Person) {
      model
        ..whoGavePresent = '${result.firstName} ${result.lastName}'
        ..whoGaveId = result.id;
      _personState.value = model.whoGavePresent;
      _personMessageState.value = null;
    }
  }

  @override
  Future<void> chooseHolidayNameScreen() async {
    final result = await router.push(
      HolidayNameRouter(
        updateHoliday: (selectedHoliday) async {
          if (selectedHoliday.id == model.holidayId) {
            final holidays = await model.getHolidays();
            final newHoliday = holidays.firstWhere((element) => element.id == selectedHoliday.id);
            model.holidayName = newHoliday.holidayName;
            _holidayNameState.value = model.holidayName;
          }
        },
      ),
    );
    if (result is Holiday) {
      model
        ..holidayName = result.holidayName
        ..holidayId = result.id;
      _holidayNameState.value = model.holidayName;
      _holidayNameMessageState.value = null;
    }
  }

  @override
  Future<void> savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  Future<void> chooseRateOnTap(int rate) async {
    model.giftRate = rate;
    _giftsState.content(model.gift);
  }

  @override
  Future<void> addGift() async {
    final isGiftNameCorrect = _giftNameController.text.isNotEmpty;
    if (!isGiftNameCorrect) {
      _giftNameValidationText = 'error';
      _formGiftNameKey.currentState?.validate();
    }
    final isPersonCorrect = _personState.value != null;
    if (!isPersonCorrect) {
      _personMessageState.value = 'error';
    }
    final isHolidayNameCorrect = _holidayNameState.value != null;
    if (!isHolidayNameCorrect) {
      _holidayNameMessageState.value = 'error';
    }
    if (isGiftNameCorrect && isPersonCorrect && isHolidayNameCorrect) {
      await model.addGift();
      await router.pop();
    }
  }

  @override
  TextEditingController get giftNameController => _giftNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  TextEditingController get priceController => _priceController;

  @override
  UnionStateNotifier<Gift> get giftsState => _giftsState;

  @override
  ValueNotifier<String?> get holidayNameState => _holidayNameState;

  @override
  ValueNotifier<String?> get personState => _personState;

  @override
  String? getHolidayNameValidationText() => _holidayNameValidationText;

  @override
  String? getPersonValidationText() => _personValidationText;

  @override
  String? getGiftNameValidationText() => _giftNameValidationText;

  ////

  @override
  ValueNotifier<String?> get personMessageState => _personMessageState;

  @override
  ValueNotifier<String?> get holidayNameMessageState => _holidayNameMessageState;

  @override
  GlobalKey<FormState> get formGiftNameKey => _formGiftNameKey;
}

/// Interface of [AddGiftGivenScreenWidgetModel].
abstract class IAddGiftGivenScreenWidgetModel implements IWidgetModel {
  /// Method to close screen.
  void closeScreen() {}

  /// Method to choose person screen.
  void choosePersonScreenOnTap() {}

  /// Method to choose holiday name.
  void chooseHolidayNameScreen() {}

  /// Method get email controller for email field.
  TextEditingController get giftNameController;

  /// Method get date controller for date field.
  TextEditingController get commentController;

  /// Method get price controller for price field.
  TextEditingController get priceController;

  /// Method to add gift.
  Future<void> addGift();

  /// Method to save photo.
  void savePhoto(Uint8List photo);

  /// Method to save rate.
  void chooseRateOnTap(int rate);

  /// Method to get gifts screen.
  UnionStateNotifier<Gift> get giftsState;

  /// Method to get holiday name state.
  ValueNotifier<String?> get holidayNameState;

  ///  Method to get person state.
  ValueNotifier<String?> get personState;

  ValueNotifier<String?> get personMessageState;

  ValueNotifier<String?> get holidayNameMessageState;

  /// Method get formKey for holiday name field
  GlobalKey<FormState> get formGiftNameKey;

  String? getHolidayNameValidationText();

  String? getPersonValidationText();

  String? getGiftNameValidationText();
}
