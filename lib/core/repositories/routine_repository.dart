import '../database/app_database.dart';
//import 'package:drift/drift.dart';

class RoutineRepository{
  final AppDatabase db;
  RoutineRepository(this.db);

  Future<int> crearRutina({
    required int userId,
    required String routineName,
    required String dayWeek,
    required DateTime creationDate
  }){
    return db.into(db.routine).insert(
      RoutineCompanion.insert(
        userId : userId,
        routineName : routineName,
        dayWeek : dayWeek,
        creationDate: creationDate,
      ),
    );
  }

  Future<int> crearDetalleRutina({
    required int routineId,
    required int exerciseId,
    required int series,
    required int repetitions,
    required double initialWeight
  }){
    return db.into(db.routineDetail).insert(
      RoutineDetailCompanion.insert(
        routineId : routineId,
        exerciseId : exerciseId,
        series : series,
        repetitions : repetitions,
        initialWeight : initialWeight,
      ),
    );
  }

  // Método para "Observar" las rutinas (Se actualiza solo si hay cambios)
  Stream<List<RoutineData>> watchAllRutinas() {
    return db.select(db.routine).watch();
  }

  // Obtener catálogo de ejercicios
  Future<List<ExerciseData>> getAllExercises() {
    return db.select(db.exercise).get(); // Devuelve la lista completa
  }

  // Método para crear un ejercicio nuevo
  Future<int> insertExercise({required String name, required String group}) {
    return db.into(db.exercise).insert(
      ExerciseCompanion.insert(
        exerciseName: name,
        muscularGroup: group,
      ),
    );
  }
}