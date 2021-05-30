import 'package:dartz/dartz.dart';
import 'package:nasa/domain/projects/entitites/project.dart';
import 'package:nasa/domain/projects/repositories/projects_repository.dart';
import 'package:nasa/errors/failures.dart';

class GetProjects {
  final ProjectsRepository? projectsRepository;

  GetProjects(this.projectsRepository);

  Future<Either<Failure, List<Project>>> call({required String start}) {
    if (start != "") {
      return projectsRepository!.getProjects(start: start);
    } else {
      return Future.value(Left(ArgsFailure()));
    }
  }
}
