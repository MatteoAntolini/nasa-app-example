import 'package:dartz/dartz.dart';
import 'package:nasa/domain/user/entities/user.dart';
import 'package:nasa/domain/user/repositories/user_repository.dart';
import 'package:nasa/errors/failures.dart';

class CreateUser {
  UserRepository? userRepository;

  CreateUser(this.userRepository);

  Future<Either<Failure, User>> call({required Map<String, dynamic> data}) {
    if (data != {}) {
      return userRepository!.createUser(data: data);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
