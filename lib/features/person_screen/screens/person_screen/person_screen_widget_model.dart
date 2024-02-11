import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/person_screen/screens/person_screen/person_screen.dart';
import 'package:flutter_template/features/person_screen/screens/person_screen/person_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [PersonScreenWidgetModel].
PersonScreenWidgetModel personScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = PersonScreenModel(
    appScope.personsService,
  );
  return PersonScreenWidgetModel(
    model,
    appScope.router,
  );
}

/// Widget model [PersonScreen]
class PersonScreenWidgetModel extends WidgetModel<PersonScreen, PersonScreenModel> with ThemeWMMixin implements IPersonScreenWidgetModel {
  /// Create an instance [PersonScreenWidgetModel].
  final AppRouter router;

  PersonScreenWidgetModel(
    super._model,
    this.router,
  );

  final _personsState = UnionStateNotifier<List<Person>>([]);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  void Function(Person selectedPerson)? deletePerson;

  @override
  void initWidgetModel() {
    _personsState.loading();
    _getPersons();
    _firstNameController.addListener(() {
      model.firstName = _firstNameController.text;
    });
    _commentController.addListener(() {
      model.comment = _commentController.text;
    });
    _lastNameController.addListener(() {
      model.lastName = _lastNameController.text;
    });
    final args = router.current.args as PersonRouterArgs?;
    deletePerson = args?.updatePerson;
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _commentController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _getPersons() async {
    try {
      final persons = await model.getPersons();
      _personsState.content(persons);
    } on Exception catch (e) {
      _personsState.failure(e);
    }
  }

  @override
  void cleanBottomSheetForAddPersonOnTap() {
    _firstNameController.text = '';
    _commentController.text = '';
    _lastNameController.text = '';
  }

  @override
  Future<void> addPersonOnTap() async {
    await model.addPerson();
    await router.pop();
  }

  @override
  Future<void> savePhotoOnTap(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  Future<void> deletePersonOnTap(Person person) async {
    await model.deletePerson(person);
    await _getPersons();
    deletePerson?.call(person);
    await router.pop();
  }

  @override
  void choosePersonOnTap(Person person) {
    router.pop(person);
  }

  @override
  void loadAgain() {
    _getPersons();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  TextEditingController get firstNameController => _firstNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  TextEditingController get lastNameController => _lastNameController;

  @override
  UnionStateNotifier<List<Person>> get personsState => _personsState;
}

/// Interface of [PersonScreenWidgetModel].
abstract interface class IPersonScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to close screen.
  void closeScreen();

  /// Navigate to load screen again
  void loadAgain();

  ///clean controllers in bottom sheet
  void cleanBottomSheetForAddPersonOnTap();

  /// Navigate to choose Person
  void choosePersonOnTap(Person person);

  ///savePhoto
  void savePhotoOnTap(Uint8List photo);

  ///add Person
  Future<void> addPersonOnTap();

  /// delete Person
  Future<void> deletePersonOnTap(Person person);

  /// Method to get persons state screen.
  UnionStateNotifier<List<Person>> get personsState;

  /// Method get email controller for first name field
  TextEditingController get firstNameController;

  /// Method get date controller for last name field
  TextEditingController get lastNameController;

  /// Method get date controller for comment field
  TextEditingController get commentController;
}
