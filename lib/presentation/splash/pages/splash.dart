import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/application/auth/auth_bloc.dart';
import 'package:nasa/application/favorites/favorites_cubit.dart';
import 'package:nasa/application/user/user_bloc.dart';
import 'package:nasa/application/user/user_state.dart';
import 'package:nasa/domain/user/entities/user.dart';
import 'package:nasa/errors/errors.dart';
import 'package:nasa/presentation/splash/dialogs/splash_error_dialogs.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/route/routes_names.dart';
import 'package:nasa/util/ui/assets.dart';
import 'package:nasa/util/ui/nasa_colors.dart';
import 'package:nasa/util/ui/ui_constants.dart';

import '../../../injection_container.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            _body(),
            Visibility(
              visible: DEBUG,
              child: Center(
                  child: Column(
                children: [
                  _authBlocConsumer(),
                  _userBlocConsumer(),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(color: PRIMARY),
      child: Center(
        child: Image.asset(NASA_LOGO, width: 300),
      ),
    );
  }

  Widget _authBlocConsumer() {
    return BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
      return Container();
    }, listener: (context, state) {
      if (state is AuthError) {
        if (state.code != NETWORK_ERROR) {
          Future.delayed(Duration(seconds: 2))
              .then((value) => _toLoginScreeen());
        } else {
          showNetworkErrorDialog(context);
        }
      } else if (state is LogoutCompleted) {
        Future.delayed(Duration(seconds: 2)).then((value) => _toLoginScreeen());
      }
    });
  }

  Widget _userBlocConsumer() {
    return BlocConsumer<UserBloc, UserState>(builder: (context, state) {
      if (state is UserCompleted) {
        return Text(state.user.id!,
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white));
      } else if (state is UserError) {
        return Text(state.code.toString());
      } else {
        return Container();
      }
    }, listener: (context, state) {
      if (state is UserCompleted) {
        final User user = state.user;
        sl.registerSingleton(user);
        context.read<FavoritesCubit>().fetchFavorites(user.favorites);
        _toHomeScreen();
      } else if (state is UserError) {
        final code = state.code;
        if (code != NETWORK_ERROR) {
          _toLoginScreeen();
        } else {
          showNetworkErrorDialog(context);
        }
      }
    });
  }

  void _toLoginScreeen() {
    Routes.seafarer.pop();
    Routes.seafarer.navigate(LOGIN_ROUTE);
  }

  void _toHomeScreen() {
    Routes.seafarer.pop();
    Routes.seafarer.navigate(HOME_ROUTE);
  }
}
