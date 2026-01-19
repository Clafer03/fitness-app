import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'create_routine_page.dart'; // La nueva página que crearemos abajo
import '../services/training_service.dart'; // Importa esto
import '../services/routine_service.dart';
import '../core/database/app_database.dart'; 

class WorkoutPage extends StatelessWidget {
  //final TrainingService trainingService; // Recibimos el servicio
  final RoutineService routineService;

  const WorkoutPage({super.key, required this.routineService});

  @override
  Widget build(BuildContext context) {
    // Simulamos tus datos (esto vendrá de tu BD)
    final rutinas = []; 

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Rutinas")),
      
      // --- AQUÍ ESTÁ LA CLAVE ---
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.orange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Nueva Rutina", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () {
          // Navegamos a la pantalla de CREACIÓN
          Navigator.push(
            context,
            MaterialPageRoute(
              // ERROR 2: Asegúrate que CreateRoutinePage acepte routineService (ver abajo)
              builder: (context) => CreateRoutinePage(routineService: routineService),
            ),
          );
        },
      ),
      // --------------------------

      body: StreamBuilder<List<RoutineData>>( // <--- Usamos RoutineData
        stream: routineService.watchRutinas(), // <--- Usamos routineService
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
          }

          final rutinas = snapshot.data ?? [];

          if (rutinas.isEmpty) {
             return _EmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rutinas.length,
            itemBuilder: (context, index) {
              final rutina = rutinas[index];
              return Card(
                color: const Color(0xFF1F2937),
                child: ListTile(
                  title: Text(rutina.routineName, style: const TextStyle(color: Colors.white)), // Usa routineName (inglés)
                  subtitle: Text(rutina.dayWeek, style: const TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.orange),
                ),
              );
            },
          );
        }
      ),
    );
  }
}

// Un widget visual para cuando no hay nada creado aún
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, size: 80, color: Colors.grey[800]),
          const SizedBox(height: 16),
          const Text(
            "No tienes rutinas aún",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            "Dale al botón + para crear\ntu primer entrenamiento",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}