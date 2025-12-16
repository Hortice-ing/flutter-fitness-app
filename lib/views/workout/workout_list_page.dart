import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/workout.dart';
import '../../providers/auth_provider.dart';
import '../../providers/workout_provider.dart';
import 'add_edit_workout_page.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({super.key});

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final workoutProv = Provider.of<WorkoutProvider>(context, listen: false);
    if (auth.user != null) workoutProv.loadWorkouts(auth.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    final workoutProv = Provider.of<WorkoutProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Séances')),
      body: ListView.builder(
        itemCount: workoutProv.workouts.length,
        itemBuilder: (context, index) {
          final w = workoutProv.workouts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.fitness_center),
              title: Text('${w.activityType} - ${w.duration} min'),
              subtitle: Text('${w.calories} calories\n${w.date}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddEditWorkoutPage(workout: w))),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await workoutProv.deleteWorkout(w.id!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditWorkoutPage()),
        ),
      ),
    );
  }
}
