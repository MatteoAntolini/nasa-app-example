import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart';
import 'package:nasa/domain/auth/usecases/login_email.dart';
import 'package:nasa/domain/auth/usecases/login_google.dart';
import 'package:nasa/domain/auth/usecases/logout.dart';
import 'package:nasa/domain/auth/usecases/register.dart';
import 'package:nasa/domain/auth/usecases/get_firebase_user.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/errors/failures.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required this.getFirebaseUser,
      required this.register,
      required this.logout,
      required this.loginWithGoogle,
      required this.loginWithEmail})
      : super(AuthInitial());

  final GetFirebaseUser? getFirebaseUser;
  final Register? register;
  final Logout? logout;
  final LoginWithGoogle? loginWithGoogle;
  final LoginWithEmail? loginWithEmail;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GetFirebaseUserEvent) {
      yield AuthLoading();
      final user = await getFirebaseUser!();
      yield* user.fold((failure) async* {
        yield AuthError(code: _mapFailuresToErrors(failure));
      }, (firebaseUser) async* {
        yield AuthCompleted(user: firebaseUser);
      });
    } else if (event is LoginWithGoogleEvent) {
      yield RegisterLoading();
      final user = await loginWithGoogle!();
      yield* user.fold((failure) async* {
        yield RegisterError(code: _mapFailuresToErrors(failure));
      }, (firebaseUser) async* {
        final data = {"id": firebaseUser.uid, "email": firebaseUser.email, "favorites": []};
        yield RegisterCompleted(user: firebaseUser, data: data);
      });
    } else if (event is LogOutEvent) {
      yield LogoutLoading();
      final response = await logout!();
      yield* response.fold((failure) async* {
        yield LogoutError(code: _mapFailuresToErrors(failure));
      }, (_) async* {
        yield LogoutCompleted();
      });
    } else if (event is LoginWithEmailEvent) {
      yield AuthLoading();
      final String email = event.email;
      final String password = event.password;
      final response = await loginWithEmail!(email: email, password: password);
      yield* response.fold((failure) async* {
        yield AuthError(code: _mapFailuresToErrors(failure));
      }, (firebaseUser) async* {
        yield AuthCompleted(user: firebaseUser);
      });
    } else if (event is RegisterEvent) {
      yield RegisterLoading();
      final email = event.email;
      final password = event.password;
      final response = await register!(
          email: email, password: password);
      yield* response.fold((failure) async* {
        yield RegisterError(code: _mapFailuresToErrors(failure));
      }, (firebaseUser) async* {
        final data = {"id": firebaseUser.uid, "email": email, "favorites": []};
        yield RegisterCompleted(user: firebaseUser, data: data);
      });
    }
  }

  int _mapFailuresToErrors(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return NETWORK_ERROR;
      case LogOutFailure:
        return LOGOUT_ERROR;
      case FirebaseUserFailure:
        return FIREBASE_AUTH_ERROR;
      case GoogleLoginFailure:
        return GOOGLE_LOGIN_ERROR;
      case EmailFailure:
        return EMAIL_ERROR;
      case InvalidPasswordFailure:
        return PASSWORD_ERROR;
      case LoginFailure:
        return LOGIN_ERROR;
      default:
        return GENERIC_ERROR;
    }
  }
}
