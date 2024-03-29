import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'holiday_database.g.dart';

class HolidaysTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get holidaysName => text()();

  DateTimeColumn get holidayDate => dateTime().nullable()();

  BlobColumn get photo => blob()();
}

@DriftDatabase(tables: [HolidaysTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
