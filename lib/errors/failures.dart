import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//General Failures

class LoginFailure extends Failure {}

class FirebaseUserFailure extends Failure {}

class EmailFailure extends Failure {}

class InvalidPasswordFailure extends Failure {}

class DifferentPasswordFailure extends Failure {}

class RegisterFailure extends Failure {}

class GoogleLoginFailure extends Failure {}

class FacebookLoginFailure extends Failure {}

class LogOutFailure extends Failure {}

class FirestoreFailure extends Failure {}

class NetworkFailure extends Failure {}

class DocumentFailure extends Failure {}

class ArgsFailure extends Failure {}

class DialogFailure extends Failure {}

class ApodFailure extends Failure {}

class ApodsFailure extends Failure {}

class FavoritesFailure extends Failure {}

class ProjectFailure extends Failure {}


