import 'package:drift/drift.dart';
import 'routine_table.dart';
import 'exercise_table.dart';

class RoutineDetail extends Table{
  IntColumn get id => integer().autoIncrement()(); //PK
  IntColumn get routineId => integer().references(Routine, #id)(); //FK
  IntColumn get exerciseId => integer().references(Exercise, #id)(); //FK

  IntColumn get series => integer()();
  IntColumn get repetitions => integer()();
  RealColumn get initialWeight => real()();
}