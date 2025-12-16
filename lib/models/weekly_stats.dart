class WeeklyStats {
  final int totalCalories;
  final int totalDuration;
  final int totalWorkouts;
  final List<int> dailyCalories;
  final Map<String, int> activityDistribution;

  WeeklyStats({
    required this.totalCalories,
    required this.totalDuration,
    required this.totalWorkouts,
    required this.dailyCalories,
    required this.activityDistribution,
  });

  factory WeeklyStats.empty() {
    return WeeklyStats(
      totalCalories: 0,
      totalDuration: 0,
      totalWorkouts: 0,
      dailyCalories: List.filled(7, 0),
      activityDistribution: {},
    );
  }
}


