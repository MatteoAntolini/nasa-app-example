// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/notification/notification_cubit.dart';
import 'package:nasa/presentation/splash/pages/splash.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/util/ui/app_theme.dart';
import 'package:nasa/util/ui/ui_constants.dart';
import 'application/auth/auth_bloc.dart';
import 'application/favorites/favorites_cubit.dart';
import 'application/theme/theme_cubit.dart';
import 'application/user/user_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  di.init();
  Routes.createRoutes();
  runApp(NasaApp());
}

class NasaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider<AuthBloc>(
          //     create: (context) => sl<AuthBloc>()..add(GetFirebaseUserEvent())),
          //BlocProvider<UserBloc>(create: (context) => sl<UserBloc>()),
          // BlocProvider<NotificationCubit>(
          //     create: (context) => sl<NotificationCubit>()),
          BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
          BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit())
        ],
        child: Builder(
          builder: (context) => BlocBuilder<ThemeCubit, ThemeState>(
              bloc: sl<ThemeCubit>(),
              builder: (context, state) {
                DARK_MODE = state.themeMode == ThemeMode.dark;
                return MaterialApp(
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: state.themeMode,
                  home: Splash(),
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: Routes.seafarer.generator(),
                  navigatorKey: Routes.seafarer.navigatorKey,
                );
              }),
        ));
  }
}
