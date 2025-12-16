import 'package:flutter/material.dart';

class GoalProgress extends StatelessWidget {
  final double current;
  final double goal;

  const GoalProgress({
    super.key,
    required this.current,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (current / goal).clamp(0.0, 1.0);

    Color color;
    if (progress < 0.7) {
      color = Colors.green;
    } else if (progress < 1.0) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Objectif hebdomadaire',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          color: color,
          backgroundColor: Colors.grey.shade300,
          minHeight: 10,
        ),
        const SizedBox(height: 8),
        Text('${(progress * 100).toStringAsFixed(1)} % atteint'),
      ],
    );
  }
}
