import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/domain/apod/usecases/get_favorites.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/errors/failures.dart';

import 'favorites_state.dart';

class FavoritesCubit extends Cubit<List<Apod>> {
  FavoritesCubit() : super([]);

  // final GetFavorites? getFavorites;

  List<Apod> _favorites = [];

  List<Apod> get favorites => _favorites;

  // void fetchFavorites(List? favorites) async {
  //   emit(FavoritesLoading());
  //   final response = await getFavorites!(dates: favorites!);
  //   emit(response
  //       .fold((failure) => FavoritesError(code: _mapFailuresToErrors(failure)),
  //           (__favorites) {
  //     _favorites = __favorites;
  //     return FavoritesCompleted(favorites: __favorites);
  //   }));
  // }

  void add(Apod apod) {
    emit([]);
    _favorites.add(apod);
    emit(_favorites);
  }

  void remove(Apod apod) {
    emit([]);
    _favorites.remove(apod);
    emit(_favorites);
  }

  int _mapFailuresToErrors(Failure failure) {
    switch (failure.runtimeType) {
      case FavoritesFailure:
        return FAVORITES_ERROR;
      case NetworkFailure:
        return NETWORK_ERROR;
      case ArgsFailure:
        return ARGS_ERROR;
      default:
        return GENERIC_ERROR;
    }
  }
}
