import 'package:flutter_template/api/data/persons_database.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';

/// Интерфейс API клиента.

class PersonsApi {
  PersonsApi(this.appPersonsDatabase);

  final AppPersonsDatabase appPersonsDatabase;

  Future<List<PersonsTableData>> getPersons() async {
    return appPersonsDatabase.select(appPersonsDatabase.personsTable).get();
  }

  Future<void> addPerson(Person person) async {
    await appPersonsDatabase.into(appPersonsDatabase.personsTable).insert(
          PersonsTableCompanion.insert(

            photo: person.photo,
            firstName: person.firstName,
            lastName: person.lastName,
            comment: person.comment,
          ),
        );
  }

  Future<void> editPerson(Person person) async {
    final resultTable = appPersonsDatabase.update(appPersonsDatabase.personsTable)..where((t) => t.id.equals(person.id));
    await resultTable.write(
      PersonsTableCompanion.insert(
        photo: person.photo,
        firstName: person.firstName,
        lastName: person.lastName,
        comment: person.comment,
      ),
    );
  }

  Future<void> deletePerson(Person person) async {
    final resultTable = appPersonsDatabase.delete(appPersonsDatabase.personsTable)..where((t) => t.id.equals(person.id));
    await resultTable.go();
  }
}
