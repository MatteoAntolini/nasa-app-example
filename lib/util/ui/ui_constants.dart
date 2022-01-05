import 'package:flutter/material.dart';
import 'package:nasa/application/theme/theme_cubit.dart';

import '../../injection_container.dart';

const DEBUG = true;
bool DARK_MODE = sl<ThemeCubit>().state.themeMode == ThemeMode.dark;