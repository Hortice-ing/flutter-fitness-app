import 'package:flutter/material.dart';

import 'sub_activities_page.dart';

class ActivitiesPage extends StatelessWidget {
  final activities = [
    "Cardio",
    "Musculation",
    "Yoga",
    "Marche",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Activités")),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(activities[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubActivitiesPage(activity: activities[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
