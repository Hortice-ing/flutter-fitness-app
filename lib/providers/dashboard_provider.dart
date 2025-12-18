import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int calories = 0;
  int seances = 0;

  void addCalories(int value) {
    calories += value;
    notifyListeners();
  }

  void addSeance() {
    seances++;
    notifyListeners();
  }
}
