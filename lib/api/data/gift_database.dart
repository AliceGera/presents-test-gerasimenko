import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'gift_database.g.dart';

class GiftsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get giftsRaiting => integer()();

  TextColumn get giftsName => text()();

  TextColumn get giftsPrice => text()();

  BoolColumn get isReceivedGifts => boolean()();

  TextColumn get whoGave => text()();

  IntColumn get whoGaveId => integer()();

  IntColumn get holidaysId => integer()();

  TextColumn get giftsComment => text()();

  BlobColumn get photo => blob()();
}

@DriftDatabase(tables: [GiftsTable])
class AppGiftsDatabase extends _$AppGiftsDatabase {
  AppGiftsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db1.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
