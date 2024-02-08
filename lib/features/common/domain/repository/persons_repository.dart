import 'package:flutter_template/api/service/persons_api.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/persons_mapper.dart';

class PersonsRepository {
  final PersonsApi _apiClient;

  PersonsRepository(this._apiClient);

  Future<List<Person>> getPersons() async {
    final some = await _apiClient.getPersons();
    return mapDatabaseToPersons(some);
  }

  Future<void> addPerson(Person data) async {
    await _apiClient.addPerson(data);
  }

  Future<void> editPerson(Person data) async {
    await _apiClient.editPerson(data);
  }
  Future<void> deletePerson(Person data) async {

    await _apiClient.deletePerson(data);
  }
}
