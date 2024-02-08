import 'package:flutter_template/api/data/persons_database.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';

List<Person> mapDatabaseToPersons(List<PersonsTableData> personsTable) {
  return personsTable
      .map(
        (e) => Person(
          id: e.id,
          firstName: e.firstName,
          lastName: e.lastName,
          comment:e.comment,
          photo: e.photo,
        ),
      )
      .toList();
}
