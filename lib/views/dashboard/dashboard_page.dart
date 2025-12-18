import 'package:flutter/material.dart';

import '../activities/activities_page.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes performances")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Calories brûlées"),
                trailing: Text("1250 kcal"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Nombre de séances"),
                trailing: Text("6"),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Voir les activités sportives"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ActivitiesPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
