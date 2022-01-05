import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/presentation/home/pages/apod/apod_screen.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(CurrentScreen(screen: ApodScreen()));

  void setScreen(Widget screen) {
    emit(CurrentScreen(screen: screen));
  }
}
