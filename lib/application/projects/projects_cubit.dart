import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/projects/projects_state.dart';
import 'package:nasa/domain/projects/usecases/get_projects.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/errors/failures.dart';

import '../../domain/projects/entitites/project.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit({required this.getProjects}) : super(ProjectsInitial());

  final _projects = <Project>[];

  final _projectsController = StreamController<List<Project>>();

  Stream<List<Project>> get projectsStream => _projectsController.stream;

  final GetProjects? getProjects;

  void fetchProjects(String? start) async {
    emit(ProjectsLoading());
    final response = await getProjects!(start: start!);
    emit(response
        .fold((failure) => ProjectsError(code: _mapFailuresToErrors(failure)),
            (projects) {
      _projects.addAll(projects.reversed.toList());
      _projectsController.sink.add(_projects);
      return ProjectsCompleted(projects: projects);
    }));
  }

  int _mapFailuresToErrors(Failure failure) {
    switch (failure.runtimeType) {
      case ProjectFailure:
        return PROJECTS_ERROR;
      case NetworkFailure:
        return NETWORK_ERROR;
      case ArgsFailure:
        return ARGS_ERROR;
      default:
        return GENERIC_ERROR;
    }
  }

  void dispose() {
    _projectsController.close();
    _projects.clear();
  }
}
