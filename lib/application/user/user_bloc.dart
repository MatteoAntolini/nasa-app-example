import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/auth/auth_bloc.dart';
import 'package:nasa/domain/user/usecases/add_favorite.dart';
import 'package:nasa/domain/user/usecases/create_user.dart';
import 'package:nasa/domain/user/usecases/get_user.dart';
import 'package:nasa/domain/user/usecases/remove_favorite.dart';
import 'package:nasa/domain/user/usecases/update_user.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/errors/failures.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
      {required this.createUser,
      required this.getUser,
      required this.updateUser,
      required this.addFavorite,
      required this.removeFavorite,
      required this.authBloc})
      : super(UserInitial()) {
    subscription = authBloc!.stream.listen((state) {
      if (state is AuthCompleted) {
        String? userId = state.user.uid;
        this.add(GetUserEvent(userId: userId));
      } else if (state is RegisterCompleted) {
        final data = state.data;
        this.add(CreateUserEvent(data: data));
      } else if (state is LogoutCompleted) {
        this.emit(UserInitial());
      }
    });
  }

  final CreateUser? createUser;
  final GetUser? getUser;
  final UpdateUser? updateUser;
  final AddFavorite? addFavorite;
  final RemoveFavorite? removeFavorite;
  final AuthBloc? authBloc;
  late StreamSubscription subscription;

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is GetUserEvent) {
      yield UserLoading();
      final userId = event.userId;
      final response = await getUser!(userId: userId!);
      yield* response.fold((failure) async* {
        yield UserError(code: _mapFailuresToErrors(failure));
      }, (user) async* {
        yield UserCompleted(user: user);
      });
    } else if (event is CreateUserEvent) {
      yield UserLoading();
      final data = event.data;
      final response = await createUser!(data: data!);
      yield* response.fold((failure) async* {
        yield UserError(code: _mapFailuresToErrors(failure));
      }, (user) async* {
        yield UserCompleted(user: user);
      });
    } else if (event is UpdateUserEvent) {
      yield UserUpdateLoading();
      final userId = event.userId;
      final data = event.data;
      final response = await updateUser!(
          userId: userId!, data: data as Map<String, dynamic>);
      yield* response.fold((failure) async* {
        yield UserUpdateError(code: _mapFailuresToErrors(failure));
      }, (user) async* {
        yield UserUpdateCompleted(user: user);
      });
    } else if (event is AddFavoriteEvent) {
      yield UserLoading();
      final userId = event.userId;
      final date = event.date;
      final response = await addFavorite!(userId: userId!, date: date!);
      yield* response.fold((failure) async* {
        yield UserError(code: _mapFailuresToErrors(failure));
      }, (user) async* {
        yield UserCompleted(user: user);
      });
    } else if (event is RemoveFavoriteEvent) {
      yield UserLoading();
      final userId = event.userId;
      final date = event.date;
      final response = await removeFavorite!(userId: userId!, date: date!);
      yield* response.fold((failure) async* {
        yield UserError(code: _mapFailuresToErrors(failure));
      }, (user) async* {
        yield UserCompleted(user: user);
      });
    }
  }

  int _mapFailuresToErrors(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return NETWORK_ERROR;
      case FirestoreFailure:
        return FIRESTORE_ERROR;
      case DocumentFailure:
        return DOCUMENT_ERROR;
      case ArgsFailure:
        return ARGS_ERROR;
      default:
        return GENERIC_ERROR;
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
