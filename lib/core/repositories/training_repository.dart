import '../database/app_database.dart';
import 'package:drift/drift.dart';
/* 
Un Repository es una capa intermedia entre:
🗄️ Base de datos (Drift / SQL)
🧠 Lógica de negocio
🎨 UI (Flutter widgets)
UI  →  Repository  →  Database
*/


class TrainingRepository {
  // 1. Encapsula la base de datos
  final AppDatabase db;
  TrainingRepository(this.db); 

// ============ ESCRITURA ============

  // 1. Recibe el PAQUETE completo del entrenamiento
  Future<int> insertTraining(TrainingCompanion training) {
    return db.into(db.training).insert(training);
  }

  // 2. Recibe el PAQUETE completo del detalle (una serie)
  Future<int> insertTrainingDetail(TrainingDetailCompanion detail) {
    return db.into(db.trainingDetail).insert(detail);
  }
// ============ LECTURA (Métodos de análisis) ============

  // Volumen total = SUM(series * repeticiones * peso usado)
  Future<double> getTrainVolume(int trainingId) async{
    // CONSULTA
    final result = await (db.select(db.trainingDetail)
    ..where((t)=> t.trainingId.equals(trainingId))).get();

    return result.fold<double>(
      0, 
      (sum, row)=>
        sum + (row.series * row.repetitions * row.usedWeight),
      );
  }

  // Progreso = Peso actual - Peso inicial
  Future<({double diff, double percent})> getWeightProcess(int trainingId, int exerciseId) async{
    // CONSULTA
    final training = await (db.select(db.training)
    ..where((t)=>t.id.equals(trainingId))).getSingle();

    final routineDetail = await(db.select(db.routineDetail)
    ..where((r) => 
        r.routineId.equals(training.routineId) & 
        r.exerciseId.equals(exerciseId))
    ).getSingle();

    final trainingDetail = await(db.select(db.trainingDetail)
    ..where((t)=> 
        t.trainingId.equals(trainingId) & 
        t.exerciseId.equals(exerciseId))
    ).getSingle();

    final double currentW = trainingDetail.usedWeight;
    final double initialW = routineDetail.initialWeight;
    final difference = currentW - initialW;

    double percentage = 0.0;
    if(initialW > 0){
      percentage = ((currentW- initialW)/initialW) * 100;
    }

    return (diff: difference, percent: percentage);
  }

  // Obtener historial con filtros opcionales
  Future<List<WorkoutHistoryItem>> getHistory({
    DateTime? startDate,
    DateTime? endDate,
    int? routineId, // Filtro opcional por rutina
  }) async {
    // 1. Consultar los entrenamientos (Trainings)
    // Hacemos JOIN con Rutina para saber el nombre
    final query = db.select(db.training).join([
      innerJoin(db.routine, db.routine.id.equalsExp(db.training.routineId))
    ]);

    // Aplicar Filtros
    if (startDate != null && endDate != null) {
      // CORRECCIÓN: Forzamos a que la fecha FIN sea a las 23:59:59
      // Así incluimos cualquier entrenamiento hecho en ese último día.
      final adjustedEndDate = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        23, 59, 59
      );
      query.where(db.training.date.isBetweenValues(startDate, adjustedEndDate)); //posible error en rango de fechas - solucionado (?)
    }
    if (routineId != null) {
      query.where(db.training.routineId.equals(routineId));
    }

    // Ordenar: Más reciente primero
    query.orderBy([OrderingTerm.desc(db.training.date)]);

    final rows = await query.get();

    // 2. Para cada entrenamiento, buscar sus detalles (Ejercicios)
    // Nota: Esto se puede optimizar con un solo query gigante, pero paso a paso es más fácil de entender.
    final List<WorkoutHistoryItem> historyItems = [];

    for (var row in rows) {
      final training = row.readTable(db.training);
      final routine = row.readTable(db.routine);

      // Buscar los detalles de ESTE entrenamiento
      // Join con Exercise para saber el nombre
      final detailsQuery = db.select(db.trainingDetail).join([
        innerJoin(db.exercise, db.exercise.id.equalsExp(db.trainingDetail.exerciseId))
      ]);
      detailsQuery.where(db.trainingDetail.trainingId.equals(training.id));
      
      final detailsRows = await detailsQuery.get();

      // Procesar los detalles para agruparlos y calcular volumen
      double totalVol = 0;
      final List<ExerciseHistoryDetail> exerciseList = [];

      // Agrupar por nombre de ejercicio (por si hiciste el mismo ejercicio separado)
      // Mapa temporal: Nombre -> Lista de series
      final Map<String, List<dynamic>> grouped = {}; 
      
      for (var dRow in detailsRows) {
        final det = dRow.readTable(db.trainingDetail);
        final ex = dRow.readTable(db.exercise);
        
        // Calculamos volumen de esta serie
        final vol = det.usedWeight * det.repetitions * det.series; // Asumiendo que 'series' es 1 por registro en tu logica nueva, o ajustar
        totalVol += vol;

        if (!grouped.containsKey(ex.exerciseName)) {
          grouped[ex.exerciseName] = [];
        }
        grouped[ex.exerciseName]!.add(det);
      }

      // Convertir el mapa a nuestra lista bonita
      grouped.forEach((name, listDetails) {
        int sets = 0;
        int reps = 0;
        double maxWeight = 0;
        double exVol = 0;

        for (var d in listDetails) {
          sets++; // Cada fila es 1 serie (según tu lógica nueva de active_workout)
          reps += (d.repetitions as int);
          if ((d.usedWeight as double) > maxWeight) maxWeight = d.usedWeight;
          exVol += (d.usedWeight * d.repetitions); // Volumen simple
        }

        exerciseList.add(ExerciseHistoryDetail(
          exerciseName: name,
          totalSets: sets,
          totalReps: reps,
          bestWeight: maxWeight,
          volume: exVol,
        ));
      });

      historyItems.add(WorkoutHistoryItem(
        trainingId: training.id,
        date: training.date,
        routineName: routine.routineName,
        durationMinutes: (training.duration / 60).round(), // De segundos a minutos
        totalVolume: totalVol,
        exercises: exerciseList,
      ));
    }

    return historyItems;
  }

}

// Clase que representa un Entrenamiento completo para el Historial
class WorkoutHistoryItem {
  final int trainingId;
  final DateTime date;
  final String routineName;
  final int durationMinutes;
  final double totalVolume; // Suma de todos los pesos x reps
  final List<ExerciseHistoryDetail> exercises; // Lista de ejercicios hechos

  WorkoutHistoryItem({
    required this.trainingId,
    required this.date,
    required this.routineName,
    required this.durationMinutes,
    required this.totalVolume,
    required this.exercises,
  });
}

// Clase para el detalle de cada renglón (ej: Press Banca: 4 series - Mejor peso 80kg)
class ExerciseHistoryDetail {
  final String exerciseName;
  final int totalSets;
  final int totalReps;
  final double bestWeight; // O promedio, según prefieras
  final double volume;

  ExerciseHistoryDetail({
    required this.exerciseName,
    required this.totalSets,
    required this.totalReps,
    required this.bestWeight,
    required this.volume,
  });
}

/* 
3. Protección del modelo
Si mañana:
cambias SQLite por API
cambias Drift por otro ORM 
*/

/*
4. ¿Qué MÁS se puede añadir al repository? (evolución natural)

Queries de lectura
Future<List<Training>> obtenerEntrenamientosPorUsuario(int userId)
Future<List<TrainingWithDetails>> obtenerEntrenamientoCompleto(int id)

Queries de progreso
Future<List<MejoraEjercicio>> obtenerMejoras()
Future<double> obtenerVolumenTotal(DateTime desde, DateTime hasta)
Future<Map<String, double>> obtenerBalanceMuscular()

Logica de validacion
if (pesoUsado < 0) {
  throw Exception('Peso inválido');
}
*/