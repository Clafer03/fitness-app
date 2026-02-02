import '../database/app_database.dart';
import 'package:drift/drift.dart';

class ProgressRepository {
  final AppDatabase db;

  ProgressRepository(this.db);

  // 1. Obtener la evolución de peso de un ejercicio específico
  // Retorna una lista de puntos: {Fecha, Peso}
  Future<List<ProgressPoint>> getExerciseProgress(int exerciseId) async {
    // Consulta: Unimos TrainingDetail con Training para tener la fecha
    final query = db.select(db.trainingDetail).join([
      innerJoin(db.training, db.training.id.equalsExp(db.trainingDetail.trainingId))
    ]);

    query.where(db.trainingDetail.exerciseId.equals(exerciseId));
    query.orderBy([OrderingTerm.asc(db.training.date)]); // Importante: Orden cronológico

    final result = await query.get();

    // Procesamiento: Si hay múltiples sets en un día, nos quedamos con el MEJOR peso de ese día
    final Map<DateTime, double> bestWeightPerDay = {};

    for (var row in result) {
      final detail = row.readTable(db.trainingDetail);
      final training = row.readTable(db.training);
      
      // Normalizamos la fecha (sin horas) para agrupar por día
      final dateKey = DateTime(training.date.year, training.date.month, training.date.day);
      
      if (!bestWeightPerDay.containsKey(dateKey) || detail.usedWeight > bestWeightPerDay[dateKey]!) {
        bestWeightPerDay[dateKey] = detail.usedWeight;
      }
    }

    // Convertimos el mapa a lista
    return bestWeightPerDay.entries
        .map((e) => ProgressPoint(date: e.key, weight: e.value))
        .toList();
  }

  // Obtener SOLO los ejercicios que tienen historial (para el dropdown limpio)
  Future<List<ExerciseData>> getTrackedExercises() async {
    // Hacemos un JOIN con TrainingDetail para filtrar solo los usados
    final query = db.select(db.exercise).join([
      innerJoin(db.trainingDetail, db.trainingDetail.exerciseId.equalsExp(db.exercise.id))
    ]);
    
    // Agrupar por ID para no traer duplicados (DISTINCT)
    query.groupBy([db.exercise.id]);
    
    // Ordenar alfabéticamente
    query.orderBy([OrderingTerm.asc(db.exercise.exerciseName)]);

    final result = await query.get();

    return result.map((row) => row.readTable(db.exercise)).toList();
  }
}

// Clase auxiliar simple (DTO)
class ProgressPoint {
  final DateTime date;
  final double weight;

  ProgressPoint({required this.date, required this.weight});
}