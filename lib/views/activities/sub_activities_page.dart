import 'package:flutter/material.dart';

class SubActivitiesPage extends StatelessWidget {
  final String activity;

  SubActivitiesPage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(activity)),
      body: Center(
        child: Text("Sous-activités de $activity"),
      ),
    );
  }
}
