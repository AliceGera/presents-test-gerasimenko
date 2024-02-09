import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/service/persons_service.dart';

/// Model fol
class PersonScreenModel extends ElementaryModel {
  PersonScreenModel(this._personsService) : super();
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

  Future<void> addPerson() async {
    await _personsService.addPerson(_person);
  }

  Future<List<Person>> getPersons() async {
    final persons = await _personsService.getPersons();
    return persons;
  }
  Future<void> deletePerson(Person person) async {
    await _personsService.deletePerson(person);
  }
}
