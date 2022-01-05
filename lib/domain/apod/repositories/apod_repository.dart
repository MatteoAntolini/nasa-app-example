import 'package:dartz/dartz.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/errors/failures.dart';

abstract class ApodRepository {
  Future<Either<Failure, List<Apod>>> getApods(
      {required String start, required String end});
  Future<Either<Failure, Apod>> getApod(
      {required String date});    
  Future<Either<Failure, List<Apod>>> getFavorites(
      {required List dates});
}
