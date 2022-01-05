import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/apod/apod_state.dart';
import 'package:nasa/domain/apod/usecases/get_apod.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/errors/failures.dart';

class ApodCubit extends Cubit<ApodState> {
  ApodCubit({
    required this.getApod,
  }) : super(ApodInitial());

  //final _apodsController = StreamController<List<Apod>>();

  //Stream<List<Apod>> get apodsStream => _apodsController.stream;

  final GetApod? getApod;

  void fetchApod(String? date) async {
    emit(ApodLoading());
    final response = await getApod!(date: date!);
    emit(response.fold(
        (failure) => ApodError(code: _mapFailuresToErrors(failure)),
        (apod) => ApodCompleted(apod: apod)));
  }

  int _mapFailuresToErrors(Failure failure) {
    switch (failure.runtimeType) {
      case ApodFailure:
        return APOD_ERROR;
      case NetworkFailure:
        return NETWORK_ERROR;
      case ArgsFailure:
        return ARGS_ERROR;
      default:
        return GENERIC_ERROR;
    }
  }
}
