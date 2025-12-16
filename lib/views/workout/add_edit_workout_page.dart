import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/workout.dart';
import '../../providers/auth_provider.dart';
import '../../providers/workout_provider.dart';

class AddEditWorkoutPage extends StatefulWidget {
  final Workout? workout;
  const AddEditWorkoutPage({super.key, this.workout});

  @override
  State<AddEditWorkoutPage> createState() => _AddEditWorkoutPageState();
}

class _AddEditWorkoutPageState extends State<AddEditWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final activityController = TextEditingController();
  final durationController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      activityController.text = widget.workout!.activityType;
      durationController.text = widget.workout!.duration.toString();
      notesController.text = widget.workout!.notes ?? '';
    }
  }

  int calculateCalories(String type, int duration) {
    final rates = {
      'Cardio': 8,
      'Musculation': 6,
      'Marche': 4,
      'Course': 10,
      'Yoga': 3,
    };
    return duration * (rates[type] ?? 5);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final workoutProv = Provider.of<WorkoutProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout != null ? 'Modifier Séance' : 'Ajouter Séance')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: activityController,
                decoration: const InputDecoration(labelText: 'Type activité'),
                validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
              ),
              TextFormField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Durée (minutes)'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
              ),
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notes (optionnel)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  int duration = int.parse(durationController.text);
                  int calories = calculateCalories(activityController.text, duration);

                  final workout = Workout(
                    id: widget.workout?.id,
                    userId: auth.user!.id,
                    activityType: activityController.text,
                    duration: duration,
                    calories: calories,
                    notes: notesController.text,
                    date: DateTime.now().toIso8601String(),
                  );

                  if (widget.workout != null) {
                    await workoutProv.updateWorkout(workout);
                  } else {
                    await workoutProv.addWorkout(workout);
                  }

                  Navigator.pop(context);
                },
                child: Text(widget.workout != null ? 'Modifier' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
