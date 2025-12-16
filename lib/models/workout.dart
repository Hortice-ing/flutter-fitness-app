class Workout {
  int? id;
  String userId;
  String activityType;
  int duration;
  int calories;
  String? notes;
  String date;

  Workout({
    this.id,
    required this.userId,
    required this.activityType,
    required this.duration,
    required this.calories,
    this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'activityType': activityType,
      'duration': duration,
      'calories': calories,
      'notes': notes,
      'date': date,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      userId: map['userId'],
      activityType: map['activityType'],
      duration: map['duration'],
      calories: map['calories'],
      notes: map['notes'],
      date: map['date'],
    );
  }
}
