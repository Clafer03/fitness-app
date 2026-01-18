import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'create_routine_page.dart'; // La nueva página que crearemos abajo
import '../services/training_service.dart'; // Importa esto


class WorkoutPage extends StatelessWidget {
  final TrainingService trainingService; // Recibimos el servicio

  const WorkoutPage({super.key, required this.trainingService});

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
            MaterialPageRoute(builder: (context) => const CreateRoutinePage()),
          );
        },
      ),
      // --------------------------

      body: _EmptyState(), 
      //    rutinas.isEmpty  ? _EmptyState() // Si no hay rutinas, mostramos un diseño bonito
      //     : ListView.builder(
      //         // ... tu lista de rutinas existente ...
      //       ),
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