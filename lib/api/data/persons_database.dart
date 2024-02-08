import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'persons_database.g.dart';

class PersonsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  TextColumn get comment => text()();

  BlobColumn get photo => blob()();
}

@DriftDatabase(tables: [PersonsTable])
class AppPersonsDatabase extends _$AppPersonsDatabase {
  AppPersonsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db2.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
