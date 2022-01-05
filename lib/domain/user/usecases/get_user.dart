import 'package:dartz/dartz.dart';
import 'package:nasa/domain/user/entities/user.dart';
import 'package:nasa/domain/user/repositories/user_repository.dart';
import 'package:nasa/errors/failures.dart';

class GetUser {
  UserRepository? userRepository;

  GetUser(this.userRepository);

  Future<Either<Failure, User>> call({required String userId}) {
    if (userId != "") {
      return userRepository!.getUser(userId: userId);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
