import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nasa/util/ui/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.dark));

  void updateAppTheme() {
    final Brightness currentBrightness = AppTheme.currentSystemBrightness;
    currentBrightness == Brightness.light
        ? setTheme(ThemeMode.light)
        : setTheme(ThemeMode.dark);
  }

  void setTheme(ThemeMode themeMode) {
    emit(ThemeState(themeMode: themeMode));
  }
}
