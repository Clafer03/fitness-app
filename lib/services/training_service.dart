import '../core/database/app_database.dart';
import '../core/repositories/training_repository.dart';

// ====== CAPA DE SERVICIOS ======
class TrainingService{
  final TrainingRepository _repository;

  TrainingService(AppDatabase db)
    :_repository = TrainingRepository(db);

  // Volumen de entrenamiento
  Future<double> getTrainVolume(int trainingId){
    return _repository.getTrainVolume(trainingId);
  }

  // Progreso
  Future<({double diff, double percent})> getWeightProcess(int trainingId, int exerciseId){
    return _repository.getWeightProcess(trainingId, exerciseId);
  }

  // Agregar mas del repositorio...
}

