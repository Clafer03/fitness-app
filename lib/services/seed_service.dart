import '../core/database/app_database.dart';

class SeedService {
  final AppDatabase db;

  SeedService(this.db);

  Future<void> seed() async {
    await _seedUser();
    await _seedExercises();
    await _seedRoutine();
    await _seedRoutineDetail();
    await _seedTraining();
    await _seedTrainingDetail();
  }

  // USUARIOS
  Future<void> _seedUser() async {
    final exists = await db.select(db.user).get();
    if (exists.isNotEmpty) return;

    await db.into(db.user).insert(
      UserCompanion.insert(userName: 'Claudio'),
    );
  }

  // EJERCICIOS
  Future<void> _seedExercises() async {
    if ((await db.select(db.exercise).get()).isNotEmpty) return;

    await db.batch((batch) {
      batch.insertAll(db.exercise, [
        ExerciseCompanion.insert(
            exerciseName: 'Press Banca', muscularGroup: 'Pecho'),
        ExerciseCompanion.insert(
            exerciseName: 'Sentadilla', muscularGroup: 'Piernas'),
        ExerciseCompanion.insert(
            exerciseName: 'Remo', muscularGroup: 'Espalda'),
        ExerciseCompanion.insert(
            exerciseName: 'Press Militar', muscularGroup: 'Hombros'),
        ExerciseCompanion.insert(
            exerciseName: 'Curl Bíceps', muscularGroup: 'Brazos'),
      ]);
    });
  }

  // RUTINA
  Future<void> _seedRoutine() async {
    if ((await db.select(db.routine).get()).isNotEmpty) return;

    await db.into(db.routine).insert(
      RoutineCompanion.insert(
        userId: 1,
        routineName: 'Push Day',
        dayWeek: 'Lunes',
        creationDate: DateTime.now(),
      ),
    );
  }

  // DETALLE RUTINA
  Future<void> _seedRoutineDetail() async {
    if ((await db.select(db.routineDetail).get()).isNotEmpty) return;

    await db.batch((batch) {
      batch.insertAll(db.routineDetail, [
        RoutineDetailCompanion.insert(
            routineId: 1, exerciseId: 1, series: 4, repetitions: 10, initialWeight: 60),
        RoutineDetailCompanion.insert(
            routineId: 1, exerciseId: 4, series: 3, repetitions: 12, initialWeight: 30),
        RoutineDetailCompanion.insert(
            routineId: 1, exerciseId: 5, series: 3, repetitions: 12, initialWeight: 20),
      ]);
    });
  }

  // ENTRENAMIENTO
  Future<void> _seedTraining() async {
    if ((await db.select(db.training).get()).isNotEmpty) return;

    await db.into(db.training).insert(
      TrainingCompanion.insert(
        userId: 1,
        routineId: 1,
        date: DateTime.now().subtract(const Duration(days: 1)),
        duration: 70,
        calories: 420,
      ),
    );
  }

  // DETALLE DE ENTRENAMIENTO
  Future<void> _seedTrainingDetail() async {
    if ((await db.select(db.trainingDetail).get()).isNotEmpty) return;

    await db.batch((batch) {
      batch.insertAll(db.trainingDetail, [
        TrainingDetailCompanion.insert(
            trainingId: 1,
            exerciseId: 1,
            series: 4,
            repetitions: 10,
            usedWeight: 65,
            completed: true),
        TrainingDetailCompanion.insert(
            trainingId: 1,
            exerciseId: 4,
            series: 3,
            repetitions: 12,
            usedWeight: 32.5,
            completed: true),
        TrainingDetailCompanion.insert(
            trainingId: 1,
            exerciseId: 5,
            series: 3,
            repetitions: 12,
            usedWeight: 22.5,
            completed: true),
      ]);
    });
  }
}
