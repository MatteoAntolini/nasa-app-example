import 'package:dartz/dartz.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/domain/apod/repositories/apod_repository.dart';
import 'package:nasa/errors/failures.dart';

class GetFavorites {
  final ApodRepository? apodRepository;

  GetFavorites(this.apodRepository);

  Future<Either<Failure, List<Apod>>> call({required List dates}) {
    return apodRepository!.getFavorites(dates: dates);
  }
}
