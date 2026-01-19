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
        // --- PECHO ---
        ExerciseCompanion.insert(exerciseName: 'Press de Banca Plano', muscularGroup: 'Pecho'),
        ExerciseCompanion.insert(exerciseName: 'Press de Banca Inclinado', muscularGroup: 'Pecho'),
        ExerciseCompanion.insert(exerciseName: 'Aperturas con Mancuernas', muscularGroup: 'Pecho'),
        ExerciseCompanion.insert(exerciseName: 'Flexiones (Push-ups)', muscularGroup: 'Pecho'),
        ExerciseCompanion.insert(exerciseName: 'Cruce de Poleas', muscularGroup: 'Pecho'),

        // --- ESPALDA ---
        ExerciseCompanion.insert(exerciseName: 'Dominadas', muscularGroup: 'Espalda'),
        ExerciseCompanion.insert(exerciseName: 'Jalón al Pecho', muscularGroup: 'Espalda'),
        ExerciseCompanion.insert(exerciseName: 'Remo con Barra', muscularGroup: 'Espalda'),
        ExerciseCompanion.insert(exerciseName: 'Remo con Mancuerna', muscularGroup: 'Espalda'),
        ExerciseCompanion.insert(exerciseName: 'Peso Muerto', muscularGroup: 'Espalda'),

        // --- PIERNAS ---
        ExerciseCompanion.insert(exerciseName: 'Sentadilla Libre', muscularGroup: 'Piernas'),
        ExerciseCompanion.insert(exerciseName: 'Prensa de Piernas', muscularGroup: 'Piernas'),
        ExerciseCompanion.insert(exerciseName: 'Zancadas (Lunges)', muscularGroup: 'Piernas'),
        ExerciseCompanion.insert(exerciseName: 'Extensiones de Cuádriceps', muscularGroup: 'Piernas'),
        ExerciseCompanion.insert(exerciseName: 'Curl Femoral', muscularGroup: 'Piernas'),
        ExerciseCompanion.insert(exerciseName: 'Elevación de Talones', muscularGroup: 'Piernas'),

        // --- HOMBROS ---
        ExerciseCompanion.insert(exerciseName: 'Press Militar', muscularGroup: 'Hombros'),
        ExerciseCompanion.insert(exerciseName: 'Elevaciones Laterales', muscularGroup: 'Hombros'),
        ExerciseCompanion.insert(exerciseName: 'Pájaros (Posterior)', muscularGroup: 'Hombros'),
        ExerciseCompanion.insert(exerciseName: 'Remo al Mentón', muscularGroup: 'Hombros'),

        // --- BRAZOS ---
        ExerciseCompanion.insert(exerciseName: 'Curl de Bíceps con Barra', muscularGroup: 'Brazos'),
        ExerciseCompanion.insert(exerciseName: 'Curl Martillo', muscularGroup: 'Brazos'),
        ExerciseCompanion.insert(exerciseName: 'Fondos en Paralelas', muscularGroup: 'Brazos'),
        ExerciseCompanion.insert(exerciseName: 'Extensiones de Tríceps', muscularGroup: 'Brazos'),
        ExerciseCompanion.insert(exerciseName: 'Press Francés', muscularGroup: 'Brazos'),

        // --- CORE / ABDOMINALES ---
        ExerciseCompanion.insert(exerciseName: 'Plancha (Plank)', muscularGroup: 'Abdominales'),
        ExerciseCompanion.insert(exerciseName: 'Crunch Abdominal', muscularGroup: 'Abdominales'),
        ExerciseCompanion.insert(exerciseName: 'Elevación de Piernas', muscularGroup: 'Abdominales'),
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
