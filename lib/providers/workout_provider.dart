import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../services/workout_service.dart';

class WorkoutProvider extends ChangeNotifier {
  final WorkoutService _service = WorkoutService();
  List<Workout> workouts = [];

  Future<void> loadWorkouts(String userId) async {
    workouts = await _service.getWorkouts(userId);
    notifyListeners();
  }

  Future<void> addWorkout(Workout workout) async {
    await _service.addWorkout(workout);
    workouts.add(workout);
    notifyListeners();
  }

  Future<void> updateWorkout(Workout workout) async {
    await _service.updateWorkout(workout);
    int index = workouts.indexWhere((w) => w.id == workout.id);
    workouts[index] = workout;
    notifyListeners();
  }

  Future<void> deleteWorkout(int id) async {
    await _service.deleteWorkout(id);
    workouts.removeWhere((w) => w.id == id);
    notifyListeners();
  }
}
