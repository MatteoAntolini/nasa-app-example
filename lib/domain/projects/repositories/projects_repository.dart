import 'package:dartz/dartz.dart';
import 'package:nasa/domain/projects/entitites/project.dart';
import 'package:nasa/errors/failures.dart';

abstract class ProjectsRepository {
 Future< Either<Failure,List<Project>>> getProjects({required String start});
}