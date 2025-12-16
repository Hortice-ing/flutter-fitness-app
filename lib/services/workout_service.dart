import '../models/workout.dart';
import 'database_service.dart';

class WorkoutService {
  final db = DatabaseService.instance;

  Future<int> addWorkout(Workout workout) async {
    final database = await db.database;
    return await database.insert('workouts', workout.toMap());
  }

  Future<int> updateWorkout(Workout workout) async {
    final database = await db.database;
    return await database.update('workouts', workout.toMap(),
        where: 'id=?', whereArgs: [workout.id]);
  }

  Future<int> deleteWorkout(int id) async {
    final database = await db.database;
    return await database.delete('workouts', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Workout>> getWorkouts(String userId) async {
    final database = await db.database;
    final res =
        await database.query('workouts', where: 'userId=?', whereArgs: [userId]);
    return res.map((e) => Workout.fromMap(e)).toList();
  }
}
