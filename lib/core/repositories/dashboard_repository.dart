import '../database/app_database.dart';
import 'package:drift/drift.dart';

class DashboardRepository {
  final AppDatabase db;

  DashboardRepository(this.db);

  // Obtener métricas de la semana actual (Lunes a Domingo)
  Future<DashboardMetrics> getWeeklyMetrics() async {
    final now = DateTime.now();
    
    // Calcular el inicio de la semana (Lunes)
    // Si hoy es martes (2), restamos 1 día. Si es domingo (7), restamos 6.
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    
    // 1. Consultar entrenamientos desde el lunes
    final query = db.select(db.training).join([
      // Unimos con TrainingDetail para sumar volumen
      leftOuterJoin(db.trainingDetail, db.trainingDetail.trainingId.equalsExp(db.training.id)),
    ]);

    query.where(db.training.date.isBiggerOrEqualValue(startOfWeek));

    final result = await query.get();

    // 2. Procesar datos en memoria (A veces es más fácil que hacer SQL complejo en Drift)
    final uniqueTrainings = <int>{};
    double totalVolume = 0;
    int totalMinutes = 0;
    int totalCalories = 0;

    for (var row in result) {
      final training = row.readTable(db.training);
      final detail = row.readTableOrNull(db.trainingDetail);

      // Sumamos tiempo y calorías solo una vez por entrenamiento
      if (!uniqueTrainings.contains(training.id)) {
        uniqueTrainings.add(training.id);
        totalMinutes += training.duration;
        totalCalories += training.calories; // Asumiendo que tienes esta columna
      }

      // Sumamos volumen de cada serie
      if (detail != null) {
        totalVolume += (detail.usedWeight * detail.repetitions);
      }
    }

    return DashboardMetrics(
      workoutsCount: uniqueTrainings.length,
      activeMinutes: (totalMinutes / 60).round(), // De segundos a minutos
      totalCalories: totalCalories,
      weeklyVolume: totalVolume,
    );
  }

  Future<List<ImprovementData>> getTopImprovements() async {
    // 1. Definir fechas: Últimos 7 días vs Histórico anterior
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    
    // 2. Obtener TODOS los detalles de entrenamiento históricos ordenados por fecha
    final query = db.select(db.trainingDetail).join([
      innerJoin(db.training, db.training.id.equalsExp(db.trainingDetail.trainingId)),
      innerJoin(db.exercise, db.exercise.id.equalsExp(db.trainingDetail.exerciseId))
    ]);
    query.orderBy([OrderingTerm.desc(db.training.date)]);
    final allHistory = await query.get();

    // 3. Agrupar datos por ejercicio
    final Map<String, Map<String, double>> exerciseStats = {}; 
    // Estructura: { "Press Banca": { "recentMax": 85.0, "historicMax": 70.0 } }

    for (var row in allHistory) {
      final detail = row.readTable(db.trainingDetail);
      final training = row.readTable(db.training);
      final exercise = row.readTable(db.exercise);
      final name = exercise.exerciseName;

      if (!exerciseStats.containsKey(name)) {
        exerciseStats[name] = {"recentMax": 0.0, "historicMax": 0.0};
      }

      if (training.date.isAfter(sevenDaysAgo)) {
        // Es reciente: actualizamos el máximo reciente si este peso es mayor
        if (detail.usedWeight > exerciseStats[name]!["recentMax"]!) {
           exerciseStats[name]!["recentMax"] = detail.usedWeight;
        }
      } else {
        // Es histórico: actualizamos el máximo histórico
         if (detail.usedWeight > exerciseStats[name]!["historicMax"]!) {
           exerciseStats[name]!["historicMax"] = detail.usedWeight;
        }
      }
    }

    // 4. Filtrar las mejoras reales y crear objetos ImprovementData
    List<ImprovementData> improvements = [];
    exerciseStats.forEach((name, stats) {
      final recent = stats["recentMax"]!;
      final historic = stats["historicMax"]!;

      // Consideramos mejora si el reciente es mayor que el histórico Y el histórico no es cero (ejercicio nuevo)
      // Y el peso reciente es significativo (> 5kg para filtrar calentamientos)
      if (recent > historic && historic > 0 && recent > 5) {
        improvements.add(ImprovementData(
          exerciseName: name,
          oldWeight: historic,
          newWeight: recent,
        ));
      }
    });

    // 5. Ordenar por porcentaje de mejora (mayor a menor) y tomar top 3
    improvements.sort((a, b) => b.percentage.compareTo(a.percentage));
    return improvements.take(3).toList();
  }

}

// Clase simple para transportar los datos (DTO)
class DashboardMetrics {
  final int workoutsCount;
  final int activeMinutes;
  final int totalCalories;
  final double weeklyVolume;

  DashboardMetrics({
    required this.workoutsCount,
    required this.activeMinutes,
    required this.totalCalories,
    required this.weeklyVolume,
  });
}

class ImprovementData {
  final String exerciseName;
  final double oldWeight;
  final double newWeight;
  
  ImprovementData({
    required this.exerciseName,
    required this.oldWeight,
    required this.newWeight,
  });

  double get percentage {
    if (oldWeight == 0) return 100;
    return ((newWeight - oldWeight) / oldWeight) * 100;
  }
}