import '../core/database/app_database.dart';
import 'package:drift/drift.dart';
// Al importar el repositorio, automáticamente importas la clase RoutineExerciseView que vive dentro de él
import '../core/repositories/routine_repository.dart'; 
import '../ui/create_routine_page.dart';

class RoutineService {
  final AppDatabase db;
  final RoutineRepository _repository;

  RoutineService(this.db)
    :_repository = RoutineRepository(db);

  Future<void> createRoutineWithExercises({
      required int userId,
      required String routineName,
      required String dayWeek,
      required DateTime creationDate,
      required List<ExerciseDraft> exercises,
    }) async {
      await db.transaction(() async {
        // 1️⃣ Crear rutina
        final routineId = await _repository.crearRutina(
          userId: userId,
          routineName: routineName,
          dayWeek: dayWeek,
          creationDate: creationDate,
        );

      // 2️⃣ Crear detalles
      for (final exercise in exercises) {
        await _repository.crearDetalleRutina(
          routineId: routineId,
          exerciseId: exercise.exerciseId,
          series: exercise.sets,
          repetitions: exercise.reps,
          initialWeight: exercise.weight,
        );
      }
    });
  }

  Stream<List<RoutineData>> watchRutinas() {
    return _repository.watchAllRutinas();
  }

  Future<List<ExerciseData>> getExercises() {
    return _repository.getAllExercises();
  }

  Future<int> createExercise(String name, String group) {
    return _repository.insertExercise(name: name, group: group);
  }

  // ============ BORRADO DE RUTINAS ============
  Future<void> deleteRoutine(int routineId) async {
    await db.transaction(() async {
      await _repository.deleteRoutineDetails(routineId);
      await _repository.deleteRoutine(routineId);
    });
  }

  // ACTUALIZAR RUTINA EXISTENTE
  Future<void> updateRoutine({
    required int routineId,
    required String routineName,
    required String dayWeek,
    required List<ExerciseDraft> newExercises,
  }) async {
    await db.transaction(() async {
      // 1. Actualizar la cabecera (Nombre y Días)
      await (db.update(db.routine)..where((t) => t.id.equals(routineId))).write(
        RoutineCompanion(
          routineName: Value(routineName),
          dayWeek: Value(dayWeek),
          // La fecha de creación no la tocamos
        ),
      );

      // 2. BORRAR los ejercicios viejos vinculados a esta rutina
      await (db.delete(db.routineDetail)..where((t) => t.routineId.equals(routineId))).go();

      // 3. INSERTAR los ejercicios nuevos (tal cual están en la lista ahora)
      for (final exercise in newExercises) {
        await _repository.crearDetalleRutina(
          routineId: routineId,
          exerciseId: exercise.exerciseId,
          series: exercise.sets,
          repetitions: exercise.reps,
          initialWeight: exercise.weight,
        );
      }
    });
  }

  // Método para obtener el plan de entrenamiento
  // Ahora Dart sabe que esta RoutineExerciseView viene del import de 'routine_repository.dart'
  Future<List<RoutineExerciseView>> getRoutineDetails(int routineId) {
    return _repository.getExercisesByRoutineId(routineId);
  }
}
