import 'package:equatable/equatable.dart';
import 'package:nasa/domain/apod/entities/apod.dart';

abstract class ApodsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApodsInitial extends ApodsState {}

class ApodsLoading extends ApodsState {}

class ApodsCompleted extends ApodsState {
  final List<Apod> apods;

  ApodsCompleted({required this.apods});

  @override
  List<Object> get props => [apods];
}

class ApodsError extends ApodsState {
  final int code;
  final String? message;

  ApodsError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}