import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:nasa/application/apod/apod_cubit.dart';
import 'package:nasa/application/apod/apod_state.dart';
import 'package:nasa/application/apods/apods_cubit.dart';
import 'package:nasa/application/apods/apods_state.dart';
import 'package:nasa/application/theme/theme_cubit.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/presentation/home/pages/apod/widgets/apod_widgets.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/route/routes_names.dart';
import 'package:nasa/util/ui/nasa_colors.dart';
import 'package:nasa/util/ui/strings.dart';
import 'package:nasa/util/ui/text_styles.dart';
import 'package:nasa/util/ui/ui_constants.dart';

import '../../../../application/apods/apods_cubit.dart';
import '../../../../application/apods/apods_state.dart';
import '../../../../injection_container.dart';

// ignore: must_be_immutable
class ApodScreen extends StatefulWidget {
  @override
  State<ApodScreen> createState() => _ApodScreenState();
}

class _ApodScreenState extends State<ApodScreen> {
  DateTime end = DateTime.now();

  DateTime start = DateTime.now().subtract(Duration(days: 30));

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>();
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        // child: NotificationListener<ScrollNotification>(
        //onNotification: (ScrollNotification notification) {
        // if (notification is ScrollEndNotification &&
        //     _controller.position.extentAfter == 0) {
        // end = start;
        // start = end.subtract(Duration(days: 30));
        // if (context.read<ApodsCubit>().state is ApodsCompleted) {
        //   context.read<ApodsCubit>().fetchApods(
        //       DateFormat("yyyy-MM-dd").format(start),
        //       DateFormat("yyyy-MM-dd").format(end));
        //}
        // }
        //return false;
        // },
        child: ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),
                iconSize: 36,
                color: DARK_MODE ? PRIMARY_LIGHT : PRIMARY,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "${Strings.EXPLORE}\n",
                      style: DARK_MODE
                          ? Styles.F1TITLE_STYLE
                          : Styles.TITLE_STYLE),
                  TextSpan(
                      text: Strings.BOUNDARIES,
                      style: DARK_MODE
                          ? Styles.F1HEADING_STYLE
                          : Styles.HEADING_STYLE)
                ]),
              ),
            ),
            SizedBox(height: 12),
            // StreamBuilder(
            //     stream: context.watch<ApodsCubit>().apodsStream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         final apods = snapshot.data;
            //         return StaggeredGridView.countBuilder(
            //           shrinkWrap: true,
            //           crossAxisCount: 4,
            //           physics: ScrollPhysics(),
            //           controller: _controller,
            //           itemCount: apods.length + 1,
            //           itemBuilder: (BuildContext context, int index) =>
            //           index >= apods.length ? ApodLoadingWidget() :
            //               ApodWidget(
            //             apod: apods[index],
            //           ),
            //           staggeredTileBuilder: (int index) =>
            //               StaggeredTile.fit(2),
            //           mainAxisSpacing: 8.0,
            //           crossAxisSpacing: 0.0,
            //         );
            //       } else {
            //         final apods = List.generate(30, (index) => null);
            //         return StaggeredGridView.countBuilder(
            //           shrinkWrap: true,
            //           physics: ScrollPhysics(),
            //           crossAxisCount: 4,
            //           itemCount: apods.length,
            //           itemBuilder: (BuildContext context, int index) =>
            //               ApodLoadingWidget(),
            //           staggeredTileBuilder: (int index) =>
            //               StaggeredTile.fit(2),
            //           mainAxisSpacing: 8.0,
            //           crossAxisSpacing: 0.0,
            //         );
            //       }
            //     }),
            // SizedBox(height: 12),
            BlocBuilder<ApodsCubit, ApodsState>(builder: (context, state) {
              if (state is ApodsCompleted) {
                final apods = state.apods;
                return Column(
                  children: [
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      controller: _controller,
                      crossAxisCount: 4,
                      itemCount: apods.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ApodWidget(
                        apod: apods[index],
                      ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.fit(2),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 0.0,
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.only(left: 100, right: 100),
                      child: MaterialButton(
                        padding: EdgeInsets.all(8),
                        color: PRIMARY,
                        onPressed: () {
                          end = start.subtract(Duration(days: 1));
                          start = end.subtract(Duration(days: 30));
                          context.read<ApodsCubit>().fetchApods(
                              DateFormat("yyyy-MM-dd").format(start),
                              DateFormat("yyyy-MM-dd").format(end));
                        },
                        child: Text(
                          Strings.LOAD,
                          style: Styles.F1H2_STYLE,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ApodsLoading) {
                final apods = List.generate(15, (index) => null);
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 4,
                  itemCount: apods.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ApodLoadingWidget(),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 0.0,
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
    );
  }
}
