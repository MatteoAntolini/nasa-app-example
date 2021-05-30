import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seafarer/seafarer.dart';

import 'package:nasa/application/favorites/favorites_cubit.dart';
import 'package:nasa/application/user/user_bloc.dart';
import 'package:nasa/application/user/user_event.dart';
import 'package:nasa/application/user/user_state.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/domain/user/entities/user.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/util/ui/text_styles.dart';

import '../../../../../injection_container.dart';

// ignore: must_be_immutable
class ApodInfo extends StatefulWidget {
  @override
  _ApodInfoState createState() => _ApodInfoState();
}

class _ApodInfoState extends State<ApodInfo> {
  double height = 150;

  Apod? apod;

  @override
  Widget build(BuildContext context) {
    apod = Seafarer.param<Apod>(context, "apod");
    Image? image = Seafarer.param(context, "image");
    if (image == null) {
      image = Image(
        image: CachedNetworkImageProvider(apod!.hdurl!),
        fit: BoxFit.fitWidth,
      );
    }
    double width = MediaQuery.of(context).size.width;

    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          int _height = info.image.height;
          int _width = info.image.width;

          setState(() {
            height = _height * width / _width;
          });
        },
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height.toDouble(),
              actionsIconTheme: null,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Routes.seafarer.pop()),
              actions: [
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is UserCompleted) {
                    final user = state.user;
                    bool favorite = user.favorites!.contains(apod!.date);

                    return IconButton(
                      onPressed: favorite
                          ? () {
                              sl<FavoritesCubit>().remove(apod!);
                              context.read<UserBloc>().add(RemoveFavoriteEvent(
                                  userId: sl<User>().id, date: apod!.date));
                            }
                          : () {
                              sl<FavoritesCubit>().add(apod!);
                              context.read<UserBloc>().add(AddFavoriteEvent(
                                  userId: sl<User>().id, date: apod!.date));
                            },
                      icon: Icon(
                          favorite ? Icons.favorite : Icons.favorite_border),
                      color: Colors.white,
                    );
                  } else {
                    return IconButton(
                        icon: Icon(Icons.favorite, color: Colors.white),
                        onPressed: null);
                  }
                })
              ],
              backgroundColor: Colors.transparent,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                      child: Hero(
                    tag: apod!.hdurl!,
                    child: Material(child: image),
                  )),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 12),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(
                      child: Hero(
                          tag: apod!.title!,
                          child: Material(
                              child: Text(apod!.title!,
                                  style: Styles.HEADING_STYLE))),
                    ),
                    Hero(
                        tag: apod!.date!,
                        child: Material(
                            child: Text(apod!.date!, style: Styles.DATE)))
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  apod!.explanation!,
                  style: Styles.BODY_STYLE,
                ),
                SizedBox(height: 12),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: "Credits: ", style: Styles.PRIMARY_HEADING),
                    TextSpan(text: apod!.copyright, style: Styles.BODY_STYLE)
                  ]),
                ),
                SizedBox(height: 12),
              ])),
            )
          ],
        ),
      ),
    );
  }
}
