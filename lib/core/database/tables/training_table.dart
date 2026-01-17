import 'package:drift/drift.dart';
import 'user_table.dart';
import 'routine_table.dart';

class Training extends Table{
  IntColumn get id => integer().autoIncrement()(); //PK
  IntColumn get userId => integer().references(User, #id)(); //FK
  IntColumn get routineId => integer().references(Routine, #id)(); //FK

  DateTimeColumn get date => dateTime()();
  IntColumn get duration => integer()();
  IntColumn get calories => integer()();
}