import 'package:dartz/dartz.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/domain/apod/repositories/apod_repository.dart';
import 'package:nasa/errors/failures.dart';

class GetApods {
  final ApodRepository? apodRepository;

  GetApods(this.apodRepository);

  Future<Either<Failure, List<Apod>>> call(
      {required String start, required String end}) {
    if (start != "" && end != "") {
      return apodRepository!.getApods(start: start, end: end);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
