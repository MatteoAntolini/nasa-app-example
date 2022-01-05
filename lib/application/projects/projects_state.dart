import 'package:equatable/equatable.dart';
import 'package:nasa/domain/projects/entitites/project.dart';

abstract class ProjectsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProjectsInitial extends ProjectsState{}

class ProjectsLoading extends ProjectsState {}

class ProjectsCompleted extends ProjectsState {
  final List<Project> projects;

  ProjectsCompleted({required this.projects});

  @override
  List<Object> get props => [projects];
}

class ProjectsError extends ProjectsState {
  final int code;
  final String? message;

  ProjectsError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}
