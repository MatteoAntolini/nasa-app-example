//FIREBASE

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:dartz/dartz.dart';
// import 'package:nasa/domain/user/entities/user.dart';
// import 'package:nasa/domain/user/repositories/user_repository.dart';
// import 'package:nasa/errors/failures.dart';
// import 'package:nasa/infrastructure/user/models/user_model.dart';
// import 'package:nasa/network/network_info.dart';

// import '../../../injection_container.dart';

// class UserRepositoryImp implements UserRepository {
//   FirebaseFirestore? database;
//   NetworkInfo? networkInfo;
//   UserRepositoryImp({required this.database, required this.networkInfo});

//   @override
//   Future<Either<Failure, User>> createUser(
//       {required Map<String, dynamic> data}) async {
//     try {
//       final userId = data["id"];
//       await database!.collection("users").doc(userId).set(data);

//       return Right(UserModel.fromJson(data));
//     } on Exception {
//       return Left(FirestoreFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, User>> getUser({required String? userId}) async {
//     if (await networkInfo!.result != ConnectivityResult.none) {
//       try {
//         final docRef = database!.collection("users").doc(userId);

//         final result = await docRef.get();

//         if (result.exists) {
//           Map data = result.data()!;
//           data["id"] = result.id;
//           final user = UserModel.fromJson(data as Map<String, dynamic>);
//           return Right(user);
//         } else {
//           return Left(DocumentFailure());
//         }
//       } catch (e) {
//         return Left(FirestoreFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, User>> updateUser(
//       {required String userId, required Map<String, dynamic> data}) async {
//     if (await networkInfo!.result != ConnectivityResult.none) {
//       try {
//         await database!.collection("users").doc(userId).update(data);

//         final oldData = sl<User>().toMap();

//         data.map((key, value) => oldData.update(key, (v) => value));

//         return Right(UserModel.fromJson(data));
//       } catch (e) {
//         return Left(FirestoreFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, User>> addFavorite(
//       {String? userId, String? date}) async {
//     if (await networkInfo!.result != ConnectivityResult.none) {
//       try {
//         await database!.collection("users").doc(userId).update({
//           "favorites": FieldValue.arrayUnion([date])
//         });

//         return getUser(userId: userId);
//       } catch (e) {
//         return Left(FirestoreFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, User>> removeFavorite(
//       {String? userId, String? date}) async {
//     if (await networkInfo!.result != ConnectivityResult.none) {
//       try {
//         await database!.collection("users").doc(userId).update({
//           "favorites": FieldValue.arrayRemove([date])
//         });

//         return getUser(userId: userId);
//       } catch (e) {
//         return Left(FirestoreFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }
// }
