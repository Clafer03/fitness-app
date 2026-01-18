import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home_page.dart'; // Tu dashboard actual
import 'workout_page.dart'; // La nueva que crearemos
import '../services/dashboard_service.dart';
import '../services/training_service.dart'; // Importa esto

class MainScreen extends StatefulWidget {
  final DashboardService dashboardService;
  final TrainingService trainingService;

  const MainScreen({super.key, required this.dashboardService, required this.trainingService});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ✅ CORRECCIÓN: Definimos la lista AQUÍ dentro para poder usar "widget."
    final List<Widget> pages = [
      // Index 0: Dashboard
      // Quitamos el 'const' porque widget.dashboardService es variable
      HomePage(dashboardService: widget.dashboardService), 
      
      // Index 1: Entrenar
      // Le pasamos el servicio de entreno para que pueda cargar rutinas
      WorkoutPage(trainingService: widget.trainingService), 
      
      // Index 2: Perfil
      const Center(child: Text("Perfil (Próximamente)", style: TextStyle(color: Colors.white))),
    ];

    return Scaffold(
      // Usamos la lista local 'pages'
      body: pages[_selectedIndex],
      
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.orange,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Progreso',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_rounded),
              label: 'Entrenar',
            ),
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