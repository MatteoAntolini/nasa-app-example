import 'package:dartz/dartz.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/domain/apod/repositories/apod_repository.dart';
import 'package:nasa/errors/failures.dart';

class GetApod {
  final ApodRepository? apodRepository;

  GetApod(this.apodRepository);

  Future<Either<Failure, Apod>> call({required String date}) {
    if (date != "") {
      return apodRepository!.getApod(date: date);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
