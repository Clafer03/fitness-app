import 'package:flutter/material.dart';
import 'core/database/app_database.dart';
import 'core/repositories/training_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  final repo = TrainingRepository(db);

  // 🔹 PRUEBA: crear entrenamiento
  final trainingId = await repo.crearEntrenamiento(
    userId: 1,
    routineId: 1,
    date: DateTime.now(),
    duration: 70,
    calories: 420,
  );

  await repo.agregarEjercicio(
    trainingId: trainingId,
    exerciseId: 1,
    series: 4,
    repetitions: 10,
    weight: 65,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Backend OK 🚀'),
        ),
      ),
    );
  }
}
