import 'package:equatable/equatable.dart';
import 'package:nasa/domain/user/entities/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserCompleted extends UserState {
  final User user;

  UserCompleted({required this.user});

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final int code;
  final String? message;

  UserError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}

class UserUpdateLoading extends UserState {}

class UserUpdateCompleted extends UserState {
  final User user;

  UserUpdateCompleted({required this.user});

  @override
  List<Object> get props => [user];
}

class UserUpdateError extends UserState {
  final int code;
  final String? message;

  UserUpdateError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}
