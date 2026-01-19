import '../core/database/app_database.dart';
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
          exerciseId: exercise.exerciseId, // IMPORTANTE → ID, no nombre
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
}