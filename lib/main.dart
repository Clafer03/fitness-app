// import 'package:flutter/material.dart';
// import 'core/database/app_database.dart';
// import 'core/repositories/training_repository.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final db = AppDatabase();
//   final repo = TrainingRepository(db);

//   // 🔹 PRUEBA: crear entrenamiento
//   final trainingId = await repo.crearEntrenamiento(
//     userId: 1,
//     routineId: 1,
//     date: DateTime.now(),
//     duration: 70,
//     calories: 420,
//   );

//   await repo.agregarEjercicio(
//     trainingId: trainingId,
//     exerciseId: 1,
//     series: 4,
//     repetitions: 10,
//     weight: 65,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Backend OK 🚀'),
//         ),
//       ),
//     );
//   }
// }
import 'package:fitness_app/services/routine_service.dart';
import 'package:fitness_app/ui/home_page.dart';
import 'package:fitness_app/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'core/database/app_database.dart';
import 'services/training_service.dart';
import 'services/dashboard_service.dart';
import 'services/seed_service.dart';
import '../ui/home_page.dart';
import '../ui/debug_table_page.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final trainingService = TrainingService(database);
  final dashboardService = DashboardService(database);
  final seedService = SeedService(database);
  final routineService = RoutineService(database);

  await seedService.seed();

  runApp(MyApp(
    database: database,
    trainingService:trainingService,
    dashboardService:dashboardService,
    routineService: routineService,
    )
  );
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final TrainingService trainingService;
  final DashboardService dashboardService;
  final RoutineService routineService;

  const MyApp({
    super.key,
    required this.database,
    required this.trainingService,
    required this.dashboardService,
    required this.routineService
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      title: 'Fitness App',
      home: MainScreen(dashboardService: dashboardService, trainingService: trainingService, routineService: routineService )//HomePage(dashboardService: dashboardService)//DebugTablePage(db: database),
    );
  }
}
