import 'package:dartz/dartz.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart';
import 'package:nasa/domain/auth/repositories/firebase_auth_repository.dart';
import 'package:nasa/errors/failures.dart';
class LoginWithGoogle {
  final FirebaseAuthRepository? firebaseAuthRepository;

  LoginWithGoogle(this.firebaseAuthRepository);

  Future<Either<Failure, FirebaseUser>> call() {
    return firebaseAuthRepository!.loginWithGoogle();
  }
}
