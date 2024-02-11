import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/service/persons_service.dart';

/// Model for
class EditPersonScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final PersonsService _personsService;
  Person _person = Person.init();

  Person get person => _person;

  set person(Person newPerson) {
    _person = newPerson;
  }

  set firstName(String newFirstName) {
    _person = _person.copyWith(firstName: newFirstName);
  }

  set lastName(String newLastName) {
    _person = _person.copyWith(lastName: newLastName);
  }

  set comment(String newComment) {
    _person = _person.copyWith(comment: newComment);
  }

  set photo(Uint8List newPhoto) {
    _person = _person.copyWith(photo: newPhoto);
  }
  set id(int newId) {
    _person = _person.copyWith(id: newId);
  }

  Future<void> editPerson() async {
    await _personsService.editPerson(_person);
  }
  Future<void> deletePerson() async {
    await _personsService.addPerson(_person);
  }

  /// Create an instance [EditPersonScreenModel].
  EditPersonScreenModel(
    this.errorHandler,
    this._personsService,
  ) : super(errorHandler: errorHandler);
}
