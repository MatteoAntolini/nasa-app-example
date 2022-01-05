import 'package:equatable/equatable.dart';
import 'package:nasa/domain/apod/entities/apod.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesCompleted extends FavoritesState {
  final List<Apod> favorites;

  FavoritesCompleted({required this.favorites});
}

class FavoritesError extends FavoritesState {
  final int code;
  final String? message;

  FavoritesError({required this.code, this.message});
}
