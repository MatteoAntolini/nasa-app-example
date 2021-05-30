import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/apods/apods_state.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/domain/apod/usecases/get_apods.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/errors/failures.dart';

class ApodsCubit extends Cubit<ApodsState> {
  ApodsCubit({required this.getApods}) : super(ApodsInitial());

  List<Apod> _apods = <Apod>[];

  final _apodsController = StreamController<List<Apod>>();

  Stream<List<Apod>> get apodsStream => _apodsController.stream;

  final GetApods? getApods;

  void fetchApods(String? start, String? end) async {
    emit(ApodsLoading());
    final response = await getApods!(start: start!, end: end!);
    emit(response.fold(
        (failure) => ApodsError(code: _mapFailuresToErrors(failure)), (apods) {
      _apods = [...apods, ..._apods];
      return ApodsCompleted(apods: _apods.reversed.toList());
      //_apodsController.sink.add(_apods);
    }));
  }

  int _mapFailuresToErrors(Failure failure) {
    switch (failure.runtimeType) {
      case ApodsFailure:
        return APODS_ERROR;
      case NetworkFailure:
        return NETWORK_ERROR;
      case ArgsFailure:
        return ARGS_ERROR;
      default:
        return GENERIC_ERROR;
    }
  }

  void dispose() {
    _apodsController.close();
    _apods.clear();
  }
}
