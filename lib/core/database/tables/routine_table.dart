import 'package:drift/drift.dart';
import 'user_table.dart';

class Routine extends Table{
  IntColumn get id => integer().autoIncrement()(); //PK
  IntColumn get userId => integer().references(User, #id)(); //FK

  TextColumn get routineName => text()();
  TextColumn get dayWeek => text()();
  DateTimeColumn get creationDate => dateTime()();
}