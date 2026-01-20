import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
// IMPORTS DE TUS PÁGINAS
import 'home_page.dart'; 
import 'workout_page.dart';
import 'history_page.dart'; // <--- IMPORTA LA NUEVA PÁGINA AQUÍ
import '../services/dashboard_service.dart';
import '../services/training_service.dart';
import '../services/routine_service.dart';

class MainScreen extends StatefulWidget {
  final DashboardService dashboardService;
  final TrainingService trainingService;
  final RoutineService routineService;

  const MainScreen({
    super.key, 
    required this.dashboardService, 
    required this.trainingService, 
    required this.routineService
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Definimos la lista de páginas en el mismo orden que los botones
    final List<Widget> pages = [
      // 0. PROGRESO (Dashboard)
      HomePage(dashboardService: widget.dashboardService), 
      
      // 1. ENTRENAR (WorkoutPage)
      WorkoutPage(
        routineService: widget.routineService, 
        trainingService: widget.trainingService,
      ), 
      
      // 2. HISTORIAL (HistoryPage) - ¡AQUÍ ESTABA EL HUECO!
      HistoryPage(
        trainingService: widget.trainingService,
        routineService: widget.routineService,
      ),
      
      // 3. PERFIL (Placeholder)
      const Center(child: Text("Perfil (Próximamente)", style: TextStyle(color: Colors.white))),
    ];

    return Scaffold(
      // Muestra la página según el índice seleccionado
      body: pages[_selectedIndex],
      
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.orange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed, // IMPORTANTE para 4 items o más
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            // ÍNDICE 0
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Progreso',
            ),
            // ÍNDICE 1
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_rounded),
              label: 'Entrenar',
            ),
            // ÍNDICE 2
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            // ÍNDICE 3
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}