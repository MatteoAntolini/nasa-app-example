import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nasa/domain/auth/entities/firebase_user.dart' as nasa;
import 'package:nasa/domain/auth/repositories/firebase_auth_repository.dart';
import 'package:nasa/errors/failures.dart';
import 'package:nasa/infrastructure/auth/models/firebase_user_model.dart';
import 'package:nasa/network/network_info.dart';

class FirebaseAuthRepositoryImp implements FirebaseAuthRepository {
  NetworkInfo? networkInfo;
  FirebaseAuth? firebaseAuth;
  GoogleSignIn? googleSignIn;

  FirebaseAuthRepositoryImp(
      {required this.networkInfo,
      required this.firebaseAuth,
      required this.googleSignIn});

  @override
  Future<Either<Failure, nasa.FirebaseUser>> loginWithEmail(
      {String? email, String? password}) async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      try {
        await firebaseAuth!.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        final response = await getFirebaseUser();

        return response.fold(
            (failure) => Left(failure), (firebaseUser) => Right(firebaseUser));
      } catch (e) {
        return Left(LoginFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, nasa.FirebaseUser>> loginWithGoogle() async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      try {
        final googleUser =
            await (googleSignIn!.signIn());
        final googleAuth = await googleUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await firebaseAuth!.signInWithCredential(credential);

        final response = await getFirebaseUser();

        return response.fold(
            (failure) => Left(failure), (firebaseUser) => Right(firebaseUser));
      } on FirebaseException {
        return Left(GoogleLoginFailure());
      } catch (error) {
        return Left(GoogleLoginFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await Future.wait([
        firebaseAuth!.signOut(),
        googleSignIn!.signOut(),
        //facebookAuth.logOut()
      ]);

      return Right(null);
    } catch (e) {
      return Left(LogOutFailure());
    }
  }

  @override
  Future<Either<Failure, nasa.FirebaseUser>> register(
      {String? email, String? password, String? confirmPassword}) async {
    try {
      await firebaseAuth!
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final response = await getFirebaseUser();

      return response.fold(
          (failure) => Left(failure), (firebaseUser) => Right(firebaseUser));
    } catch (e) {
      return Left(RegisterFailure());
    }
  }

  @override
  Future<Either<Failure, nasa.FirebaseUser>> getFirebaseUser() async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      final user = firebaseAuth!.currentUser;

      if (user != null) {
        final String uid = user.uid;
        final String? displayName = user.displayName;
        final String? email = user.email;

        FirebaseUserModel firebaseUser =
            FirebaseUserModel(uid: uid, name: displayName, email: email);

        return Right(firebaseUser);
      } else {
        return Left(FirebaseUserFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
