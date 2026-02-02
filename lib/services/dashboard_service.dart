import '../core/database/app_database.dart';
import '../core/repositories/dashboard_repository.dart';

// 1. MODELO DE DATOS (DTO)
class DashboardData {
  final String userName;
  final int workoutsCount; 
  final int activeMinutes; 
  final int totalCalories; 
  final double weeklyVolume;
  final List<ImprovementData> improvements; // Lista de mejoras

  DashboardData({
    required this.userName,
    required this.workoutsCount,
    required this.activeMinutes,
    required this.totalCalories,
    required this.weeklyVolume,
    required this.improvements,
  });
}

// 2. LA CLASE DEL SERVICIO
class DashboardService {
  final AppDatabase _db;
  final DashboardRepository _repository; 

  DashboardService(AppDatabase db) 
      : _db = db,
        _repository = DashboardRepository(db);

  // Obtener datos del Dashboard (MÉTODO ÚNICO Y COMPLETO)
  Future<DashboardData> getDashboardData(int userId) async {
    // A. Obtener el nombre del usuario
    final user = await (_db.select(_db.user)..where((u) => u.id.equals(userId))).getSingle();
    
    // B. Obtener las métricas SEMANALES desde el repositorio
    final metrics = await _repository.getWeeklyMetrics();
    
    // C. Obtener las MEJORAS DESTACADAS
    final improvements = await _repository.getTopImprovements();

    // D. Retornar los datos consolidados para la UI
    return DashboardData(
      userName: user.userName,
      workoutsCount: metrics.workoutsCount,
      activeMinutes: metrics.activeMinutes,
      totalCalories: metrics.totalCalories,
      weeklyVolume: metrics.weeklyVolume,
      improvements: improvements, // Pasamos la lista aquí
    );
  }
}