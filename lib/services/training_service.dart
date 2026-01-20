import 'package:drift/drift.dart';
import '../core/database/app_database.dart';
import '../core/repositories/training_repository.dart';

// ====== CAPA DE SERVICIOS ======
class TrainingService {
  final AppDatabase db; // Necesitamos la DB para la transacción
  final TrainingRepository _repository;

  TrainingService(this.db) : _repository = TrainingRepository(db);

  // ============ MÉTODO ESTRELLA: GUARDAR ENTRENAMIENTO ============
  Future<void> saveFinishedWorkout({
    required int userId,
    required int routineId,
    required int durationSeconds,
    required List<TrainingDetailCompanion> details,
  }) async {
    
    // Transacción: O se guarda todo, o no se guarda nada (Seguridad de datos)
    await db.transaction(() async {
      // 1. Guardar la Cabecera
      final trainingId = await _repository.insertTraining(
        TrainingCompanion.insert(
          userId: userId,
          routineId: routineId,
          date: DateTime.now(),
          duration: durationSeconds,
          calories: 0, // Aquí podrías calcular calorías = duración * 0.15 aprox
        ),
      );

      // 2. Guardar cada serie asignándole el ID del entrenamiento creado
      for (var detail in details) {
        final detailWithId = detail.copyWith(trainingId: Value(trainingId));
        await _repository.insertTrainingDetail(detailWithId);
      }
    });
  }

  // Progreso
  Future<({double diff, double percent})> getWeightProcess(int trainingId, int exerciseId){
    return _repository.getWeightProcess(trainingId, exerciseId);
  }

  // Histórico
  Future<List<WorkoutHistoryItem>> getWorkoutHistory({
    DateTime? start, 
    DateTime? end, 
    int? filterRoutineId
  }) {
    return _repository.getHistory(startDate: start, endDate: end, routineId: filterRoutineId);
  }
  // Agregar mas del repositorio...
}

