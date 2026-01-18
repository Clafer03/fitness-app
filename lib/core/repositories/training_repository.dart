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

  // 2. Define operaciones del dominio (no SQL)
  Future<int> crearEntrenamiento({
    required int userId,
    required int routineId,
    required DateTime date,
    required int duration,
    required int calories,
  }) {
    return db.into(db.training).insert(
      TrainingCompanion.insert(
        userId: userId,
        routineId: routineId,
        date: date,
        duration: duration,
        calories: calories,
      ),
    );
  }

  Future<void> agregarEjercicio({
    required int trainingId,
    required int exerciseId,
    required int series,
    required int repetitions,
    required double weight,
  }) {
    return db.into(db.trainingDetail).insert(
      TrainingDetailCompanion.insert(
        trainingId: trainingId,
        exerciseId: exerciseId,
        series: series,
        repetitions: repetitions,
        usedWeight: weight,
        completed: true,
      ),
    );
  }

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