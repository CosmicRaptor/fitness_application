import 'package:flutter/foundation.dart';

class Workout {
  final String name;
  final String id;
  final int steps;
  Workout({
    required this.name,
    required this.id,
    required this.steps,
  });

  Workout copyWith({
    String? name,
    String? id,
    int? steps,
  }) {
    return Workout(
      name: name ?? this.name,
      id: id ?? this.id,
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'steps': steps,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      steps: map['steps'] ?? 0,
    );
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Workout &&
        other.name == name &&
        other.id == id &&
        other.steps == steps;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    id.hashCode ^
    steps.hashCode;
  }
}