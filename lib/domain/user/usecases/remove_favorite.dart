import 'package:dartz/dartz.dart';
import 'package:nasa/domain/user/entities/user.dart';
import 'package:nasa/domain/user/repositories/user_repository.dart';
import 'package:nasa/errors/failures.dart';

class RemoveFavorite {
  final UserRepository? userRepository;

  RemoveFavorite(this.userRepository);

  Future<Either<Failure, User>> call(
      {required String userId, required String date}) {
    if (userId != "" && date != "") {
      return userRepository!.removeFavorite(userId: userId, date: date);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
