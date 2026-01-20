import '../database/app_database.dart';
import 'package:drift/drift.dart'; // Necesario para innerJoin y select

class RoutineRepository {
  final AppDatabase db;
  RoutineRepository(this.db);

  // 1. CREAR RUTINA
  Future<int> crearRutina({
    required int userId,
    required String routineName,
    required String dayWeek,
    required DateTime creationDate
  }) {
    return db.into(db.routine).insert(
      RoutineCompanion.insert(
        userId: userId,
        routineName: routineName,
        dayWeek: dayWeek,
        creationDate: creationDate,
      ),
    );
  }

  // 2. CREAR DETALLE
  Future<int> crearDetalleRutina({
    required int routineId,
    required int exerciseId,
    required int series,
    required int repetitions,
    required double initialWeight
  }) {
    return db.into(db.routineDetail).insert(
      RoutineDetailCompanion.insert(
        routineId: routineId,
        exerciseId: exerciseId,
        series: series,
        repetitions: repetitions,
        initialWeight: initialWeight,
      ),
    );
  }

  // 3. OBSERVAR RUTINAS
  Stream<List<RoutineData>> watchAllRutinas() {
    return db.select(db.routine).watch();
  }

  // 4. OBTENER EJERCICIOS (CATÁLOGO)
  Future<List<ExerciseData>> getAllExercises() {
    return db.select(db.exercise).get(); 
  }

  // 5. INSERTAR NUEVO EJERCICIO
  Future<int> insertExercise({required String name, required String group}) {
    return db.into(db.exercise).insert(
      ExerciseCompanion.insert(
        exerciseName: name,
        muscularGroup: group,
      ),
    );
  }

  // 6. BORRAR DETALLES
  Future<int> deleteRoutineDetails(int routineId) {
    return (db.delete(db.routineDetail)..where((tbl) => tbl.routineId.equals(routineId))).go();
  }

  // 7. BORRAR RUTINA
  Future<int> deleteRoutine(int id) {
    return (db.delete(db.routine)..where((tbl) => tbl.id.equals(id))).go();
  }

  // 8. OBTENER EL PLAN DE ENTRENAMIENTO (JOIN)
  Future<List<RoutineExerciseView>> getExercisesByRoutineId(int routineId) async {
    // Hacemos un JOIN entre RoutineDetail y Exercise
    final query = db.select(db.routineDetail).join([
      innerJoin(
        db.exercise, 
        db.exercise.id.equalsExp(db.routineDetail.exerciseId)
      ),
    ]);

    // Filtramos por la rutina que queremos
    query.where(db.routineDetail.routineId.equals(routineId));

    // Ejecutamos y mapeamos los resultados a nuestra clase bonita
    final result = await query.get();

    return result.map((row) {
      final detail = row.readTable(db.routineDetail);
      final exercise = row.readTable(db.exercise);

      return RoutineExerciseView(
        detailId: detail.id,
        exerciseId: exercise.id,
        exerciseName: exercise.exerciseName,
        muscularGroup: exercise.muscularGroup,
        targetSets: detail.series,
        targetReps: detail.repetitions,
        targetWeight: detail.initialWeight,
      );
    }).toList();
  }
} // <--- FIN DE LA CLASE REPOSITORY

// =========================================================
// AGREGA ESTO AL FINAL DEL ARCHIVO (FUERA DE LA CLASE) 👇
// =========================================================

class RoutineExerciseView {
  final int detailId;
  final int exerciseId;
  final String exerciseName;
  final String muscularGroup;
  final int targetSets;
  final int targetReps;
  final double targetWeight;

  RoutineExerciseView({
    required this.detailId,
    required this.exerciseId,
    required this.exerciseName,
    required this.muscularGroup,
    required this.targetSets,
    required this.targetReps,
    required this.targetWeight,
  });
}