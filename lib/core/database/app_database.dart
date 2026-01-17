import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/user_table.dart';
import 'tables/exercise_table.dart';
import 'tables/routine_table.dart';
import 'tables/routine_detail_table.dart';
import 'tables/training_table.dart';
import 'tables/training_detail_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    User,
    Exercise,
    Routine,
    RoutineDetail,
    Training,
    TrainingDetail,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fitness.db'));
    return NativeDatabase(file);
  });
}