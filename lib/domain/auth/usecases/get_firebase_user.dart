import 'package:dartz/dartz.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart';
import 'package:nasa/domain/auth/repositories/firebase_auth_repository.dart';
import 'package:nasa/errors/failures.dart';

class GetFirebaseUser {
  final FirebaseAuthRepository? firebaseAuthRepository;

  GetFirebaseUser(this.firebaseAuthRepository);

  Future<Either<Failure, FirebaseUser>> call() {
    return firebaseAuthRepository!.getFirebaseUser();
  }
}
