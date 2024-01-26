
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_application/core/constants/constants.dart';
import 'package:fitness_application/core/constants/firebase_constants.dart';
import 'package:fitness_application/core/failure.dart';
import 'package:fitness_application/core/type_defs.dart';
import 'package:fitness_application/providers/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../models/user_model.dart';


final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseFirestore: ref.read(firestoreProvider),
    firebaseAuth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firebaseFirestore,
        required FirebaseAuth firebaseAuth,
        required GoogleSignIn googleSignIn})
      : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      final googleauth = await googleuser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleauth?.accessToken,
        idToken: googleauth?.idToken,
      );

      UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);
      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser){
        userModel = UserModel(
            name: userCredential.user!.displayName!,
            profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
            banner: Constants.bannerDefault,
            uid: userCredential.user!.uid, );
        print(userModel.toString());

        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      }

      else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
      //print(userCredential.user!.email);
    }

    on FirebaseException catch (e){
      throw e.message!;
    }

    catch (E) {
      return left(Failure(message: E.toString()));
    }
  }

  Stream<UserModel> getUserData (String uid){
    return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}