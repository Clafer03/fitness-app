import 'package:flutter/material.dart';
import '../services/dashboard_service.dart';
import '../services/progress_service.dart';
import '../theme/app_colors.dart';
import '../widgets/metric_card.dart';
import '../widgets/improvement_card.dart'; // Tu nuevo widget verde
import 'detailed_progress_page.dart';     // La página de gráficos
import '../core/repositories/dashboard_repository.dart'; // Importante: Para reconocer "ImprovementData"

class HomePage extends StatelessWidget {
  final DashboardService dashboardService;
  final ProgressService progressService;

  const HomePage({
      super.key, 
      required this.dashboardService,
      required this.progressService
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen Semanal'), 
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF111827),

      body: SafeArea(
        child: FutureBuilder<DashboardData>(
          // Cargamos los datos del usuario 1
          future: dashboardService.getDashboardData(1), 
          builder: (context, snapshot) {
            
            // 1. ESTADO DE CARGA
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. ESTADO DE ERROR
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
            }

            // 3. SIN DATOS
            if (!snapshot.hasData) {
              return const Center(child: Text('No hay datos disponibles', style: TextStyle(color: Colors.white)));
            }

            final data = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SALUDO Y TÍTULO ---
                  Text(
                    'Hola, ${data.userName}! 👋',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Tu actividad de esta semana",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // --- SECCIÓN 1: GRID DE MÉTRICAS (KPIs) ---
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), 
                    childAspectRatio: 1.4,
                    children: [ 
                      MetricCard(
                        title: 'Entrenos',
                        value: '${data.workoutsCount}',
                        unit: 'Sesiones',
                        icon: Icons.fitness_center,
                        color: AppColors.blue,
                      ),
                      MetricCard(
                        title: 'Tiempo Activo',
                        value: '${data.activeMinutes}',
                        unit: 'Minutos',
                        icon: Icons.access_time_filled_rounded,
                        color: AppColors.green,
                      ),
                      MetricCard(
                        title: 'Volumen Total',
                        value: formattedVolume(data.weeklyVolume),
                        unit: 'Kg totales',
                        icon: Icons.line_weight, 
                        color: AppColors.purple,
                      ),
                      MetricCard(
                        title: 'Gasto',
                        value: '${data.totalCalories}',
                        unit: 'Kcal',
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // --- SECCIÓN 2: MEJORAS DESTACADAS ---
                  // Solo pintamos esta sección si la lista NO está vacía
                  if (data.improvements.isNotEmpty) ...[
                     const Text(
                      "Mejoras Destacadas 🔥",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 16),
                    
                    // Generamos una tarjeta por cada mejora
                    ...data.improvements.map((improvement) => ImprovementCard(data: improvement)),
                  ],

                  const SizedBox(height: 30),

                  // --- SECCIÓN 3: BOTÓN A DETALLES ---
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.orange),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Pasamos el servicio de progreso a la nueva página
                            builder: (context) => DetailedProgressPage(progressService: progressService),
                          ),
                        );
                      },
                      child: const Text("Ver Análisis Detallado 📈", style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  // Espacio extra al final para que no quede pegado en pantallas pequeñas
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper para formatear volúmenes grandes (12000 -> 12K)
  String formattedVolume(double volume) {
    if (volume >= 1000000) {
        return '${(volume / 1000000).toStringAsFixed(1)}M';
    }
    if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }
    return volume.toStringAsFixed(0);
  }
}