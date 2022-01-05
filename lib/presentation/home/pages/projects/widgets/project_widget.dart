import 'package:flutter/material.dart';
import 'package:nasa/domain/projects/entitites/project.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/route/routes_names.dart';
import 'package:nasa/util/ui/strings.dart';
import 'package:nasa/util/ui/text_styles.dart';
import 'package:nasa/util/ui/ui_constants.dart';
import 'package:shimmer/shimmer.dart';

class ProjectWidget extends StatelessWidget {
  final Project project;

  ProjectWidget({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => Routes.seafarer
            .navigate(PROJECT_INFO_ROUTE, params: {"project": project}),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  project.title!,
                  style: DARK_MODE ? Styles.F1H2_STYLE : Styles.H2_STYLE,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${Strings.STATUS} : ",
                        style: DARK_MODE
                            ? Styles.F1BODY_STYLE
                            : Styles.BODY_STYLE),
                    TextSpan(
                        text: project.status,
                        style:
                            DARK_MODE ? Styles.F1BODY_STYLE : Styles.BODY_STYLE)
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Shimmer.fromColors(
        baseColor: DARK_MODE ? Colors.grey[800]! : Colors.grey[400]!,
        highlightColor: DARK_MODE ? Colors.grey[600]! : Colors.grey[200]!,
        child: Container(
          height: 150,
          color: Colors.white,
        ),
      ),
    );
  }
}
