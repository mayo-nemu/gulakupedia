import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final usersCollection = FirebaseFirestore.instance.collection(
    'artifacts/gulapedia/users',
  );

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) {
      if (firebaseUser == null) {
        // If no Firebase user, emit an empty MyUser
        return Stream.value(MyUser.empty());
      } else {
        // Listen to real-time changes of the user's document in Firestore
        return usersCollection
            .doc(firebaseUser.uid)
            .snapshots() // <--- CHANGE IS HERE: .snapshots() instead of .get()
            .map((docSnapshot) {
              if (docSnapshot.exists && docSnapshot.data() != null) {
                return MyUser.fromEntity(
                  MyUserEntity.fromJson(docSnapshot.data()!),
                );
              } else {
                return MyUser.empty().copyWith(
                  userId: firebaseUser.uid,
                  email: firebaseUser.email ?? '',
                ); // Basic user
              }
            });
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      return myUser.copyWith(userId: user.user!.uid);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection.doc(myUser.userId).set(myUser.toEntity().toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> changeUserPassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );
      await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
