import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
// Asegúrate de importar el modelo ImprovementData correctamente según tu estructura
import '../core/repositories/dashboard_repository.dart';

class ImprovementCard extends StatelessWidget {
  final ImprovementData data;

  const ImprovementCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Formateamos los pesos para quitar decimales .0 si son enteros
    final String oldW = data.oldWeight % 1 == 0 ? data.oldWeight.toStringAsFixed(0) : data.oldWeight.toString();
    final String newW = data.newWeight % 1 == 0 ? data.newWeight.toStringAsFixed(0) : data.newWeight.toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Un fondo oscuro ligeramente diferente para resaltar
        color: const Color(0xFF1A2230), 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nombre del ejercicio
          Expanded(
            child: Text(
              data.exerciseName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Sección derecha: Porcentaje y pesos
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Porcentaje verde (+21%)
              Text(
                "+${data.percentage.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: AppColors.green, // Usa tu color verde brillante
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              // Comparativa (70kg -> 85kg)
              Text(
                "$oldW kg → $newW kg",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}