import 'package:drift/drift.dart';
import 'training_table.dart';
import 'exercise_table.dart';

class TrainingDetail extends Table{
  IntColumn get id => integer().autoIncrement()(); //PK
  IntColumn get trainingId => integer().references(Training, #id)(); //FK
  IntColumn get exerciseId => integer().references(Exercise, #id)(); //FK

  IntColumn get series => integer()();
  IntColumn get repetitions => integer()();
  RealColumn get usedWeight => real()();
  BoolColumn get completed => boolean()();
}