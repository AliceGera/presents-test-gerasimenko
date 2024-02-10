import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [AddGiftReceivedScreenWidgetModel].
AddGiftReceivedScreenWidgetModel addGiftReceivedScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = AddGiftReceivedScreenModel(
    appDependencies.errorHandler,
    appScope.giftsService,
  );
  final router = appDependencies.router;
  return AddGiftReceivedScreenWidgetModel(model, router);
}

/// Widget Model for [AddGiftReceivedScreen].
class AddGiftReceivedScreenWidgetModel extends WidgetModel<AddGiftReceivedScreen, AddGiftReceivedScreenModel> implements IAddGiftReceivedScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [AddGiftReceivedScreenModel].
  AddGiftReceivedScreenWidgetModel(
    super._model,
    this.router,
  );

  final _giftsState = UnionStateNotifier<Gift>(Gift.init());
  final _holidayNameState = ValueNotifier<String?>(null);
  final _personState = ValueNotifier<String?>(null);
  final TextEditingController _giftNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initWidgetModel() {
    _giftNameController.addListener(() {
      model.giftName = _giftNameController.text;
    });
    _commentController.addListener(() {
      model.giftComment = _commentController.text;
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _giftNameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> choosePersonScreenOnTap() async {
    final result = await router.push(PersonRouter());
    if (result is Person) {
      model.whoGavePresent = '${result.firstName} ${result.lastName}';
      _personState.value = model.whoGavePresent;
    }
  }

  @override
  Future<void> chooseHolidayNameScreen() async {
    final result = await router.push(HolidayNameRouter());
    if (result is Holiday) {
      model
        ..holidayName = result.holidayName
        ..holidayId = result.id;
      _holidayNameState.value = model.holidayName;
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
    await model.addGift();
    await router.pop();
  }

  @override
  TextEditingController get giftNameController => _giftNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  UnionStateNotifier<Gift> get giftsState => _giftsState;

  @override
  ValueNotifier<String?> get holidayNameState => _holidayNameState;

  @override
  ValueNotifier<String?> get personState => _personState;
}

/// Interface of [AddGiftReceivedScreenWidgetModel].
abstract class IAddGiftReceivedScreenWidgetModel implements IWidgetModel {
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

  /// Method to add gift.
  Future<void> addGift();

  /// Method to save photo.
  void savePhoto(Uint8List photo);

  /// Method to save rate.
  void chooseRateOnTap(int rate);

  /// Method to get holidays screen.
  UnionStateNotifier<Gift> get giftsState;

  /// Method to get holiday name state.
  ValueNotifier<String?> get holidayNameState;

  ///  Method to get person state.
  ValueNotifier<String?> get personState;
}
