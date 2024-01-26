import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_application/core/constants/firebase_constants.dart';
import 'package:fitness_application/core/failure.dart';
import 'package:fitness_application/core/type_defs.dart';
import 'package:fitness_application/models/user_model.dart';
import 'package:fitness_application/models/workout.dart';
import 'package:fitness_application/providers/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userProfileRepositoryProvider = Provider((ref) {
    return UserProfileRepository(firestore: ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  CollectionReference get _workouts =>
      _firestore.collection(FirebaseConstants.workoutsCollection);

  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Stream<List<Workout>> getWorkouts(String uid) {
    return _workouts
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Workout.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
