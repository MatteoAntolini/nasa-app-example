import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nasa/application/apod/apod_cubit.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/route/routes_names.dart';
import 'package:nasa/util/ui/text_styles.dart';
import 'package:nasa/util/ui/ui_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';

class ApodWidget extends StatelessWidget {
  final Apod apod;

  ApodWidget({required this.apod});

  @override
  Widget build(BuildContext context) {
    Image image = Image(
      image: CachedNetworkImageProvider(apod.hdurl!),
      fit: BoxFit.fitWidth,
    );

    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => Routes.seafarer
                .navigate(APOD_INFO_ROUTE, params: {"apod": apod, "image": image}),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                    tag: apod.hdurl!,
                    // child: ExtendedImage.network(
                    //   apod.hdurl,
                    //   width: 400,
                    //   height:400,
                    //   fit: BoxFit.fill,
                    //   cache: true,
                    //   ),
                    child: Material(
                      child: CachedNetworkImage(
                        imageUrl: apod.hdurl!,
                        memCacheHeight: 400,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                          ),
                          baseColor:
                              DARK_MODE ? Colors.grey[800]! : Colors.grey[400]!,
                          highlightColor:
                              DARK_MODE ? Colors.grey[600]! : Colors.grey[200]!,
                        ),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 30),
            child: Hero(
              tag: apod.title!,
              child: Material(
                child: Text(
                  apod.title!,
                  style: Styles.APOD_TITLE_STYLE,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 50),
            child: Hero(
              tag: apod.date!,
              child: Material(
                child: Text(
                  apod.date!,
                  style: Styles.APOD_DATE_STYLE,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ApodLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Shimmer.fromColors(
        baseColor: DARK_MODE ? Colors.grey[800]! : Colors.grey[400]!,
        highlightColor: DARK_MODE ? Colors.grey[600]! : Colors.grey[200]!,
        child: Container(
          child: Column(
            children: [
              Container(
                height: ((Random().nextInt(20) + 10) * 10).toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 30, top: 8),
                child: Container(height: 20, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 50, top: 8),
                child: Container(height: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showApodCalendarDialog(BuildContext context) async {
  DateTime now = DateTime.now();
  final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000, 1),
      lastDate: now);

  if (date != null) {
    context.read<ApodCubit>().fetchApod(DateFormat("yyyy-MM-dd").format(date));
  }
}
