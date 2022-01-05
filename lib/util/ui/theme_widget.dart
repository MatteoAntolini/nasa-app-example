import 'package:flutter/material.dart';
import 'package:nasa/application/theme/theme_cubit.dart';

import '../../injection_container.dart';

class ThemeWidget extends StatelessWidget {
  final bool isLight;

  ThemeWidget({required this.isLight});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(isLight ? Icons.wb_sunny : Icons.nightlight_round),
        onPressed: () {
          isLight
              ? sl<ThemeCubit>().setTheme(ThemeMode.dark)
              : sl<ThemeCubit>().setTheme(ThemeMode.light);
        });
  }
}
