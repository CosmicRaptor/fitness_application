import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_application/core/failure.dart';
import 'package:fitness_application/core/type_defs.dart';
import 'package:fitness_application/providers/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final workoutRepositoryProvider = Provider((ref) {
  return WorkoutRepository(firebaseFirestore: ref.read(firestoreProvider));
});
class WorkoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  WorkoutRepository(
      {required FirebaseFirestore firebaseFirestore})
      :_firebaseFirestore = firebaseFirestore;

  FutureVoid saveTodaysSteps(int steps) async{
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentTime = DateTime.now();
      final date = DateTime(currentTime.year, currentTime.month, currentTime.day);
      print(date);
      print(date.toIso8601String());
      final todaySteps = steps - prefs.getInt(date.subtract(const Duration(days: 1)).toIso8601String())!;
      prefs.setInt(date.toIso8601String(), todaySteps);
      return right(todaySteps);
    }
    catch (e){
      return left(Failure(message: e.toString()));
    }
  }

}
