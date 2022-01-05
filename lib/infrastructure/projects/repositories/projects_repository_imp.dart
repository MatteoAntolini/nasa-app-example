import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:nasa/domain/projects/entitites/project.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa/domain/projects/repositories/projects_repository.dart';
import 'package:nasa/errors/failures.dart';
import 'package:nasa/infrastructure/projects/models/project_model.dart';
import 'package:nasa/network/network_info.dart';
import 'package:nasa/util/enviroment/enviroment.dart';

class ProjectsRepositoryImp extends ProjectsRepository {
  final NetworkInfo? networkInfo;

  ProjectsRepositoryImp({this.networkInfo});

  @override
  Future<Either<Failure, List<Project>>> getProjects({String? start}) async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      try {
        final response = await get(Uri.parse(
            "https://api.nasa.gov/techport/api/projects?updatedSince=$start&api_key=$NASA_API_KEY"));

        List data = json.decode(response.body)["projects"];

        List<Project> projects = [];

        var client = Client();

        List<Response> list = await Future.wait(data.map((item) => client.get(
            Uri.parse(
                "https://api.nasa.gov/techport/api/projects/${item["projectId"]}?api_key=$NASA_API_KEY"))));

        list.forEach((request) {
          try {
            final project = json.decode(request.body)["project"];
            projects.add(ProjectModel.fromMap(project));
          } catch (e) {
            print(e);
          }
        });

        return Right(projects);
      } catch (e) {
        return Left(ProjectFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
