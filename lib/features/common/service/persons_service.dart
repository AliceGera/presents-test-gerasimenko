import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/domain/repository/persons_repository.dart';

class PersonsService {
  final PersonsRepository _personsRepository;

  PersonsService(this._personsRepository);

  Future<Future<List<Person>>> getPersons() async {
    return _personsRepository.getPersons();
  }

  Future<void> addPerson(Person data) async {
    await _personsRepository.addPerson(data);
  }

  Future<void> editPerson(Person data) async {
    await _personsRepository.editPerson(data);
  }

  Future<void> deletePerson(Person data) async {
    await _personsRepository.deletePerson(data);
  }
}
