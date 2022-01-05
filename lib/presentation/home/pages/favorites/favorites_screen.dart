import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nasa/application/favorites/favorites_cubit.dart';
import 'package:nasa/application/favorites/favorites_state.dart';
import 'package:nasa/application/theme/theme_cubit.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/presentation/home/pages/apod/widgets/apod_widgets.dart';
import 'package:nasa/util/ui/nasa_colors.dart';
import 'package:nasa/util/ui/strings.dart';
import 'package:nasa/util/ui/text_styles.dart';
import 'package:nasa/util/ui/ui_constants.dart';

import '../../../../injection_container.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>();
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
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
                    text: "${Strings.YOUR}\n",
                    style:
                        DARK_MODE ? Styles.F1TITLE_STYLE : Styles.TITLE_STYLE),
                TextSpan(
                    text: Strings.FAVORITES,
                    style: DARK_MODE
                        ? Styles.F1HEADING_STYLE
                        : Styles.HEADING_STYLE)
              ]),
            ),
          ),
          SizedBox(height: 12),
          BlocBuilder<FavoritesCubit, List<Apod>>(
              builder: (context, favorites) {
            final _favorites = favorites.reversed.toList();
            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 4,
              itemCount: _favorites.length,
              itemBuilder: (BuildContext context, int index) => ApodWidget(
                apod: _favorites[index],
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 0.0,
            );
            // if (state is FavoritesCompleted) {
            //   final favorites = state.favorites.reversed.toList();
            //   return StaggeredGridView.countBuilder(
            //     shrinkWrap: true,
            //     physics: ScrollPhysics(),
            //     crossAxisCount: 4,
            //     itemCount: favorites.length,
            //     itemBuilder: (BuildContext context, int index) =>
            //         ApodWidget(
            //       apod: favorites[index],
            //     ),
            //     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            //     mainAxisSpacing: 8.0,
            //     crossAxisSpacing: 0.0,
            //   );
            // } else if (state is FavoritesLoading) {
            //   final favorites = List.generate(30, (index) => null);
            //   return StaggeredGridView.countBuilder(
            //     shrinkWrap: true,
            //     physics: ScrollPhysics(),
            //     crossAxisCount: 4,
            //     itemCount: favorites.length,
            //     itemBuilder: (BuildContext context, int index) =>
            //         ApodLoadingWidget(),
            //     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            //     mainAxisSpacing: 8.0,
            //     crossAxisSpacing: 0.0,
            //   );
            // } else {
            //   return Container();
            // }
          })
        ],
      ),
    );
  }
}
