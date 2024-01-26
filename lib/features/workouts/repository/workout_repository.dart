import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  WorkoutRepository(
      {required FirebaseFirestore firebaseFirestore,
      required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;


  
}
