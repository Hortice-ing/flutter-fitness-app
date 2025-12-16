import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  final List<int> calories;

  const WeeklyChart({
    super.key,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: List.generate(
            calories.length,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: calories[i].toDouble(),
                  width: 14,
                  borderRadius: BorderRadius.circular(6),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
