import 'package:equatable/equatable.dart';
import 'package:nasa/domain/apod/entities/apod.dart';

abstract class ApodState {}

class ApodInitial extends ApodState {}

class ApodLoading extends ApodState {}

class ApodCompleted extends ApodState {
  final Apod apod;

  ApodCompleted({required this.apod});
}

class ApodError extends ApodState {
  final int code;
  final String? message;

  ApodError({required this.code, this.message});
}
