import 'package:dartz/dartz.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart';
import 'package:nasa/domain/auth/repositories/firebase_auth_repository.dart';
import 'package:nasa/errors/failures.dart';
import 'package:nasa/util/validation/email_validation.dart';
import 'package:nasa/util/validation/password_validation.dart';

class Register {
  final FirebaseAuthRepository? firebaseAuthRepository;

  Register(this.firebaseAuthRepository);

  Future<Either<Failure, FirebaseUser>> call(
      {required String email, String? password}) {
    if (EmailValidation.validator(email) &&
        PasswordValidation.validator(password!)) {
      return firebaseAuthRepository!.register(
          email: email, password: password);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
