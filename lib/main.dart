import 'package:fitness_app/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'core/database/app_database.dart';
import 'services/training_service.dart';
import 'services/routine_service.dart';
import 'services/dashboard_service.dart';
import 'services/seed_service.dart';
import 'theme/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_ES', null);

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
      // ----------------------------------------
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Inglés
        Locale('es', 'ES'), // Español <--- ¡IMPORTANTE!
      ],
      // ----------------------------------------
      home: MainScreen(dashboardService: dashboardService, trainingService: trainingService, routineService: routineService )//HomePage(dashboardService: dashboardService)//DebugTablePage(db: database),
    );
  }
}
