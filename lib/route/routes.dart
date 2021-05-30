import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/presentation/home/pages/apod/apod_info/apod_info.dart';
import 'package:nasa/presentation/home/pages/projects/project_info/project_info.dart';
import 'package:nasa/presentation/home/view/home.dart';
import 'package:nasa/presentation/login/pages/login.dart';
import 'package:nasa/route/routes_names.dart';
import 'package:seafarer/seafarer.dart';

import '../main.dart';

class Routes {
  static final seafarer = Seafarer();

  static void createRoutes() {
    seafarer.addRoutes([
      SeafarerRoute(
          name: NASA_APP_ROUTE,
          builder: (context, args, params) {
            return NasaApp();
          }),
      SeafarerRoute(
          name: LOGIN_ROUTE,
          builder: (context, args, params) {
            return Login();
          }),
      SeafarerRoute(
          name: HOME_ROUTE,
          builder: (context, args, params) {
            return Home();
          }),
      SeafarerRoute(
          name: APOD_INFO_ROUTE,
          params: [
            SeafarerParam<Apod>(name: "apod"),
            SeafarerParam(name: "image")
          ],
          builder: (context, args, params) {
            return ApodInfo();
          }),
      SeafarerRoute(
          name: PROJECT_INFO_ROUTE,
          params: [SeafarerParam<Apod>(name: "project")],
          builder: (context, args, params) {
            return ProjectInfo();
          })
    ]);
  }
}
