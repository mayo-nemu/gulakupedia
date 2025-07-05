import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection;

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((
      User? firebaseUser,
    ) async* {
      if (firebaseUser == null) {
        yield MyUser.empty();
      } else {
        final docSnapshot = await _usersCollection.doc(firebaseUser.uid).get();
        final Map<String, dynamic> userData =
            docSnapshot.data()! as Map<String, dynamic>;
        yield MyUser.fromEntity(MyUserEntity.fromJson(userData));
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
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error during sign-in: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Generic Error during sign-in: $e');
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

      MyUser updatedMyUser = myUser.copyWith(userId: user.user!.uid);

      return updatedMyUser;
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error during sign-up: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Generic Error during sign-up: $e');
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await _usersCollection.doc(myUser.userId).set(myUser.toEntity().toJson());
    } catch (e) {
      log('Generic Error during user setup: $e');
      rethrow;
    }
  }
}
