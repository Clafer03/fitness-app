import '../core/database/app_database.dart';
import '../core/repositories/progress_repository.dart';

class ProgressService {
  final AppDatabase db; // Necesario para obtener la lista de ejercicios (catálogo)
  final ProgressRepository _repository;

  ProgressService(this.db) : _repository = ProgressRepository(db);

  // Obtener lista de todos los ejercicios para el dropdown
  // Future<List<ExerciseData>> getAllExercises() {
  //   return db.select(db.exercise).get();
  // }
  Future<List<ExerciseData>> getTrackedExercises() {
    return _repository.getTrackedExercises();
  }

  // Obtener datos del gráfico
  Future<List<ProgressPoint>> getProgressForExercise(int exerciseId) {
    return _repository.getExerciseProgress(exerciseId);
  }
}