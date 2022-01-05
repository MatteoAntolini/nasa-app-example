import 'package:dartz/dartz.dart';
import 'package:nasa/domain/auth/repositories/firebase_auth_repository.dart';
import 'package:nasa/errors/failures.dart';

class Logout {
  final FirebaseAuthRepository? firebaseAuthRepository;

  Logout(this.firebaseAuthRepository);

  Future<Either<Failure, void>> call() {
    return firebaseAuthRepository!.logOut();
  }
}
