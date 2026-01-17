import 'package:drift/drift.dart';

class User extends Table{
  IntColumn get id => integer().autoIncrement()(); //PK
  
  TextColumn get userName => text()();
  //añadir mas elementos proximamente...
}