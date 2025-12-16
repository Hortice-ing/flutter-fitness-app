import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../widgets/activity_pie_chart.dart';
import '../../widgets/goal_progress.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/weekly_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      final dashboard =
          Provider.of<DashboardProvider>(context, listen: false);
      // ⚡ On utilise un "userId" fixe pour bypasser l'auth
      //dashboard.loadWeeklyStats("default_user");
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = Provider.of<DashboardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Dashboard'),
        actions: [
          // Optionnel : retirer logout car pas d'auth
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final dashboard =
              Provider.of<DashboardProvider>(context, listen: false);
          //await dashboard.loadWeeklyStats("default_user");
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Calories',
                      value: dashboard.weeklyStats.totalCalories.toString(),
                      icon: Icons.local_fire_department,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      title: 'Durée (min)',
                      value: dashboard.weeklyStats.totalDuration.toString(),
                      icon: Icons.timer,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StatCard(
                title: 'Séances',
                value: dashboard.weeklyStats.totalWorkouts.toString(),
                icon: Icons.fitness_center,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              GoalProgress(
                current: dashboard.weeklyStats.totalDuration.toDouble(),
                goal: dashboard.weeklyGoal,
              ),
              const SizedBox(height: 24),
              WeeklyChart(
                calories: dashboard.weeklyStats.dailyCalories,
              ),
              const SizedBox(height: 24),
              ActivityPieChart(
                data: dashboard.weeklyStats.activityDistribution,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
