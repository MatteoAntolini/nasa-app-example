import 'package:dartz/dartz.dart';
import 'package:nasa/domain/user/entities/user.dart';
import 'package:nasa/errors/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser({required String userId});
  Future<Either<Failure, User>> updateUser(
      {required String userId, required Map<String, dynamic> data});
  Future<Either<Failure, User>> createUser(
      {required Map<String, dynamic> data});

  Future<Either<Failure, User>> addFavorite(
      {required String userId, required String date});
  Future<Either<Failure, User>> removeFavorite(
      {required String userId, required String date});
}
