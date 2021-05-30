import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/apod/apod_cubit.dart';
import 'package:nasa/application/auth/auth_bloc.dart';
import 'package:nasa/application/home/home_cubit.dart';
import 'package:nasa/application/notification/notification_cubit.dart';
import 'package:nasa/application/notification/notification_state.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/presentation/home/pages/apod/apod_screen.dart';
import 'package:nasa/presentation/home/pages/apod/widgets/apod_widgets.dart';
import 'package:nasa/presentation/home/pages/favorites/favorites_screen.dart';
import 'package:nasa/presentation/home/pages/projects/projects_screen.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/route/routes_names.dart';
import 'package:nasa/util/ui/nasa_colors.dart';
import 'package:nasa/util/ui/strings.dart';
import 'package:nasa/util/ui/ui_constants.dart';

import '../../../injection_container.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (cotext) => sl<HomeCubit>(),
        ),
        BlocProvider<ApodCubit>(create: (context) => sl<ApodCubit>()),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          floatingActionButton: Visibility(
            visible: context.read<HomeCubit>().state.screen is ApodScreen,
            child: FloatingActionButton(
              onPressed: () => showApodCalendarDialog(context),
              backgroundColor: SECONDARY,
              child: Icon(Icons.search),
            ),
          ),
          drawer: Drawer(
              child: ListView(
            children: [
              DrawerHeader(
                child: Text('NASA APP'),
                decoration: BoxDecoration(
                  color: DARK_MODE ? PRIMARY_LIGHT : PRIMARY,
                ),
              ),
              ListTile(
                title: Text(Strings.APOD),
                onTap: () {
                  context.read<HomeCubit>().setScreen(ApodScreen());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(Strings.FAVORITES),
                onTap: () {
                  context.read<HomeCubit>().setScreen(FavoritesScreen());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(Strings.PROJECTS),
                onTap: () {
                  context.read<HomeCubit>().setScreen(ProjectsScreen());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  context.read<AuthBloc>().add(LogOutEvent());
                  Navigator.pop(context);
                  Routes.seafarer.navigate(NASA_APP_ROUTE);
                },
              ),
            ],
          )),
          body: Stack(
            children: [
              SafeArea(child: context.watch<HomeCubit>().state.screen),
              
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationReceived) {
                    final notification = state.notification;
                    final date = notification.data!["date"];
                    context.read<ApodCubit>().fetchApod(date);
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _toApodInfoScreen(Apod apod) {
    //Routes.Seafarer.pop();
    Routes.seafarer.navigate(APOD_INFO_ROUTE, params: {"apod": apod});
  }
}
