// import 'package:flutter/material.dart';
// import '../services/training_service.dart';

// class HomePage extends StatefulWidget {
//   final TrainingService trainingService;

//   const HomePage({super.key, required this.trainingService});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   double? volume;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Fitness Tracker')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 final result =
//                     await widget.trainingService.getTrainVolume(1);

//                 setState(() {
//                   volume = result;
//                 });
//               },
//               child: const Text('Calcular volumen entrenamiento'),
//             ),
//             const SizedBox(height: 20),
//             if (volume != null)
//               Text(
//                 'Volumen total: ${volume!.toStringAsFixed(2)} kg',
//                 style: const TextStyle(fontSize: 18),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../services/dashboard_service.dart';

// class HomePage extends StatelessWidget {
//   final DashboardService dashboardService;

//   const HomePage({super.key, required this.dashboardService});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: FutureBuilder<DashboardData>(
//         future: dashboardService.getDashboardData(1),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final data = snapshot.data!;

//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 _metric('🔥 Calorías hoy', '${data.caloriesToday} kcal'),
//                 _metric('⏱ Tiempo activo', '${data.durationToday} min'),
//                 _metric('📦 Volumen total', data.volumeToday.toStringAsFixed(1)),
//                 _metric('📆 Racha', '${data.streak} días'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _metric(String title, String value) {
//     return Card(
//       child: ListTile(
//         title: Text(title),
//         trailing: Text(
//           value,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../services/dashboard_service.dart';
import '../widgets/metric_card.dart';
import '../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  final DashboardService dashboardService;

  const HomePage({super.key, required this.dashboardService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No definimos backgroundColor porque ya viene del AppTheme
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        // 1. Recuperamos el FutureBuilder para tener "data"
        child: FutureBuilder<DashboardData>(
          future: dashboardService.getDashboardData(1), // ID de usuario de prueba
          builder: (context, snapshot) {
            
            // Estado de carga
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Manejo de errores (importante para producción)
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No hay datos disponibles'));
            }

            // Aquí "nace" la variable data
            final data = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, ${data.userName}! 💪',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    // Importante: Physics para que no choque con el SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(), 
                    childAspectRatio: 1.4,
                    // 2. Quitamos el "const" aquí porque los valores cambian
                    children: [ 
                      MetricCard(
                        title: 'Calorías Hoy',
                        value: '${data.caloriesToday}',
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.orange,
                      ),
                      MetricCard(
                        title: 'Tiempo Activo',
                        value: '${data.durationToday}m',
                        icon: Icons.access_time_filled_rounded,
                        color: AppColors.blue,
                      ),
                      MetricCard(
                        title: 'Racha',
                        value: '${data.streak} días', // Corregido de "m" a "días"
                        icon: Icons.calendar_today_rounded,
                        color: AppColors.green,
                      ),
                      MetricCard(
                        title: 'Volumen Total',
                        value: formattedVolume(data.volumeToday),
                        icon: Icons.trending_up_rounded,
                        color: AppColors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Esta función está perfecta aquí para lógica de la UI específica de esta página
  String formattedVolume(double volume) {
    if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }
    return volume.toStringAsFixed(1);
  }
}
