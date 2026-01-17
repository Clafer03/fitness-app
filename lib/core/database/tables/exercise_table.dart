import 'package:drift/drift.dart';

class Exercise extends Table{
  IntColumn get id => integer().autoIncrement()(); //PK

  TextColumn get exerciseName => text()();
  TextColumn get muscularGroup => text()();
}