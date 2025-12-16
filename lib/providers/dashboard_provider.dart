import 'package:flutter/material.dart';

import '../models/weekly_stats.dart';
import '../services/statistics_service.dart';

class DashboardProvider extends ChangeNotifier {
  final StatisticsService _statsService = StatisticsService();

  WeeklyStats weeklyStats = WeeklyStats.empty();
  double weeklyGoal = 150;

  Future<void> loadWeeklyStats(int userId) async {
    weeklyStats = await _statsService.getWeeklyStats(userId);
    notifyListeners();
  }
}


