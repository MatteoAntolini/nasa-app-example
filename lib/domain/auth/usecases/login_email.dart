import 'package:dartz/dartz.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart';
import 'package:nasa/domain/auth/repositories/firebase_auth_repository.dart';
import 'package:nasa/errors/failures.dart';

class LoginWithEmail {
  final FirebaseAuthRepository? firebaseAuthRepository;

  LoginWithEmail(this.firebaseAuthRepository);

  Future<Either<Failure, FirebaseUser>> call({String? email, String? password}) {
    if (email != null && password != null) {
      return firebaseAuthRepository!.loginWithEmail(
          email: email, password: password);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
