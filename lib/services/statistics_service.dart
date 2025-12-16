import '../models/weekly_stats.dart';
import 'database_service.dart';

class StatisticsService {
  final DatabaseService _db = DatabaseService();

  Future<WeeklyStats> getWeeklyStats(int userId) async {
    final db = await _db.database;

    final summary = await db.rawQuery('''
      SELECT 
        SUM(calories) as totalCalories,
        SUM(duration) as totalDuration,
        COUNT(*) as totalWorkouts
      FROM workouts
      WHERE userId = ?
      AND date >= date('now','-6 days')
    ''', [userId]);

    final daily = await db.rawQuery('''
      SELECT strftime('%w', date) as day, SUM(calories) as calories
      FROM workouts
      WHERE userId = ?
      AND date >= date('now','-6 days')
      GROUP BY day
    ''', [userId]);

    final activity = await db.rawQuery('''
      SELECT activityType, COUNT(*) as count
      FROM workouts
      WHERE userId = ?
      GROUP BY activityType
    ''', [userId]);

    final dailyCalories = List<int>.filled(7, 0);
    for (final row in daily) {
      final d = int.parse(row['day'].toString());
      dailyCalories[d == 0 ? 6 : d - 1] = row['calories'] as int? ?? 0;
    }

    return WeeklyStats(
      totalCalories: summary.first['totalCalories'] as int? ?? 0,
      totalDuration: summary.first['totalDuration'] as int? ?? 0,
      totalWorkouts: summary.first['totalWorkouts'] as int? ?? 0,
      dailyCalories: dailyCalories,
      activityDistribution: {
        for (final e in activity)
          e['activityType'] as String: e['count'] as int
      },
    );
  }
}
