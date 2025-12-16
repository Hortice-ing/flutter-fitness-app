import 'package:flutter/material.dart';

import 'views/home/dashboard_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Log',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardPage(), // ⚡ Accès direct au Dashboard
    );
  }
}
