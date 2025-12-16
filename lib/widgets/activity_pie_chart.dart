import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityPieChart extends StatelessWidget {
  final Map<String, int> data;

  const ActivityPieChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple
    ];

    int index = 0;

    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            final color = colors[index++ % colors.length];
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: entry.key,
              color: color,
              radius: 60,
            );
          }).toList(),
        ),
      ),
    );
  }
}
