import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for
EditGiftReceivedScreenWidgetModel editGiftReceivedScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = EditGiftReceivedScreenModel(
    appDependencies.errorHandler,
    appScope.giftsService,
    appScope.holidaysService,
  );
  final router = appDependencies.router;
  return EditGiftReceivedScreenWidgetModel(model, router);
}

/// Widget Model for [EditGiftReceivedScreenWidgetModel].
class EditGiftReceivedScreenWidgetModel extends WidgetModel<EditGiftReceivedScreen, EditGiftReceivedScreenModel> implements IEditGiftReceivedScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [EditGiftReceivedScreenModel].
  EditGiftReceivedScreenWidgetModel(
    super._model,
    this.router,
  );

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _giftNameController = TextEditingController();
  final ValueNotifier<Gift> _giftState = ValueNotifier<Gift>(Gift.init());
  void Function(Holiday)? _updateHoliday;

  @override
  void dispose() {
    _commentController.removeListener(_commentListener);
    _giftNameController.removeListener(_giftListener);
    _commentController.dispose();
    _giftNameController.dispose();
    super.dispose();
  }

  void _commentListener() {
    model.giftComment = _commentController.text;
  }

  void _giftListener() {
    model.giftName = _giftNameController.text;
  }

  @override
  void initWidgetModel() {
    final args = router.current.args as EditGiftReceivedRouterArgs?;

    _commentController.addListener(_commentListener);
    _giftNameController.addListener(_giftListener);

    if (args != null) {
      model
        ..gift = args.gift
        ..holidayName = args.holiday.holidayName
        ..holidayId = args.holiday.id;
      _commentController.text = args.gift.giftComment;
      _giftNameController.text = args.gift.giftName;
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
      model.whoGave = '${result.firstName} ${result.lastName}';
      model.whoGaveId = result.id;
      _giftState.value = model.gift;
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
    }
  }

  @override
  Future<void> editGiftOnTap() async {
    await model.editGift();
    await router.pop();
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
  ValueNotifier<Gift> get giftState => _giftState;
}

/// Interface of [EditGiftReceivedScreenWidgetModel].
abstract class IEditGiftReceivedScreenWidgetModel implements IWidgetModel {
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

  ///Method get gift state.
  ValueNotifier<Gift> get giftState;
}
