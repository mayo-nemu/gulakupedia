import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dartz/dartz.dart';

import 'package:user_repository/src/errors/failures.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection;

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _usersCollection = FirebaseFirestore.instance.collection(
        'artifacts/gulapedia/users',
      );

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((User? firebaseUser) {
      if (firebaseUser == null) {
        return Stream.value(MyUser.empty());
      } else {
        return _usersCollection
            .doc(firebaseUser.uid)
            .snapshots()
            .map((docSnapshot) {
              if (!docSnapshot.exists || docSnapshot.data() == null) {
                return MyUser.empty();
              }
              final Map<String, dynamic> userData =
                  docSnapshot.data()! as Map<String, dynamic>;
              return MyUser.fromEntity(MyUserEntity.fromJson(userData));
            })
            .onErrorReturnWith((error, stackTrace) {
              log('Error fetching user data from Firestore: $error');
              return MyUser.empty();
            });
      }
    });
  }

  @override
  Future<Either<Failure, Unit>> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error during sign-in: ${e.code} - ${e.message}');
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An unexpected authentication error occurred.';
      }
      return left(AuthFailure(message, e.code));
    } catch (e, st) {
      log('Generic Error during sign-in: $e', stackTrace: st);
      return left(ServerFailure('An unexpected error occurred.', e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyUser>> signUp(MyUser myUser, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: myUser.email,
            password: password,
          );

      if (userCredential.user == null) {
        return left(
          AuthFailure('Failed to create user: no user credential.', 'no-user'),
        );
      }

      MyUser updatedMyUser = myUser.copyWith(userId: userCredential.user!.uid);
      return right(updatedMyUser);
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error during sign-up: ${e.code} - ${e.message}');
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'The email address is already in use by another account.';
          break;
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An unexpected registration error occurred.';
      }
      return left(AuthFailure(message, e.code));
    } catch (e, st) {
      log('Generic Error during sign-up: $e', stackTrace: st);
      return left(
        ServerFailure(
          'An unexpected error occurred during sign-up.',
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(unit);
    } catch (e, st) {
      log('Error during logout: $e', stackTrace: st);
      return left(ServerFailure('Failed to log out.', e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setUserData(MyUser myUser) async {
    try {
      await _usersCollection.doc(myUser.userId).set(myUser.toEntity().toJson());

      return right(unit);
    } catch (e, st) {
      log('Generic Error during user data setup: $e', stackTrace: st);
      return left(ServerFailure('Failed to set user data.', e.toString()));
    }
  }
}
