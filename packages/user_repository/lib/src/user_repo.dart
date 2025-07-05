import 'package:dartz/dartz.dart';
import 'package:user_repository/src/errors/failures.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;

  Future<Either<Failure, MyUser>> signUp(MyUser myUser, String password);

  Future<Either<Failure, Unit>> setUserData(MyUser myUser);

  Future<Either<Failure, Unit>> signIn(String email, String password);

  Future<Either<Failure, Unit>> logOut();
}
