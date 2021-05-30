import 'package:dartz/dartz.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart';
import 'package:nasa/errors/failures.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, FirebaseUser>> loginWithEmail(
      {String? email, String? password});

  Future<Either<Failure, FirebaseUser>> loginWithGoogle();

  Future<Either<Failure, void>> logOut();

  Future<Either<Failure, FirebaseUser>> register(
      {String? email, String? password});

  Future<Either<Failure, FirebaseUser>> getFirebaseUser();
}
