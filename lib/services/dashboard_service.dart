import '../core/database/app_database.dart';
import 'package:drift/drift.dart';

class DashboardData {
  final String userName;
  final int caloriesToday;
  final int durationToday;
  final double volumeToday;
  final int streak;

  DashboardData({
    required this.userName,
    required this.caloriesToday,
    required this.durationToday,
    required this.volumeToday,
    required this.streak,
  });
}

class DashboardService {
  final AppDatabase db;

  DashboardService(this.db);

  // Obtener nombre, calorias, duracion, volumen, racha
  Future<DashboardData> getDashboardData(int userId) async {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));

    // Nombre de usuario
    final user = await (db.select(db.user)..where((u) => u.id.equals(userId))).getSingle();
    final name = user.userName;
    // Entrenamientos de hoy
    final trainingsToday = await (db.select(db.training)
          ..where((t) =>
              t.userId.equals(userId) &
              t.date.isBetweenValues(start, end)))
        .get();

    int calories = 0;
    int duration = 0;
    double volume = 0;

    for (final t in trainingsToday) {
      calories += t.calories;
      duration += t.duration;

      final details = await (db.select(db.trainingDetail)
            ..where((d) => d.trainingId.equals(t.id)))
          .get();

      for (final d in details) {
        volume += d.series * d.repetitions * d.usedWeight;
      }
    }

    final streak = await _calculateStreak(userId);

    return DashboardData(
      userName: name,
      caloriesToday: calories,
      durationToday: duration,
      volumeToday: volume,
      streak: streak,
    );
  }

  // Calcular racha
  Future<int> _calculateStreak(int userId) async {
    final trainings = await (db.select(db.training)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.date),
          ]))
        .get();

    if (trainings.isEmpty) return 0;

    int streak = 0;
    DateTime current = DateTime.now();

    for (final t in trainings) {
      final day = DateTime(t.date.year, t.date.month, t.date.day);
      final expected = DateTime(current.year, current.month, current.day);

      if (day == expected || day == expected.subtract(const Duration(days: 1))) {
        streak++;
        current = day;
      } else {
        break;
      }
    }

    return streak;
  }
}
