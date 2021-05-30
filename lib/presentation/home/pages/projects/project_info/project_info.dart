import 'package:flutter/material.dart';
import 'package:nasa/domain/projects/entitites/project.dart';
import 'package:nasa/route/routes.dart';
import 'package:nasa/util/ui/strings.dart';
import 'package:nasa/util/ui/text_styles.dart';
import 'package:seafarer/seafarer.dart';

class ProjectInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Project project = Seafarer.param(context, "project");
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Routes.seafarer.pop(),
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(child: Text(project.title!, style: Styles.H2_STYLE))
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Strings.DESCRIPTION,
                    style: Styles.PRIMARY_HEADING,
                  ),
                  Text(
                    parse(project.description!),
                    style: Styles.BODY_STYLE,
                  ),
                  SizedBox(height: 12),
                  Text(
                    Strings.BENEFITS,
                    style: Styles.PRIMARY_HEADING,
                  ),
                  Text(parse(project.benefits!), style: Styles.BODY_STYLE),
                  SizedBox(height: 12),
                  Text(
                    Strings.DATES,
                    style: Styles.PRIMARY_HEADING,
                  ),
                  Text(Strings.START + " " + project.startDate!, style: Styles.BODY_STYLE),
                  Text(Strings.END + " " + project.endDate!, style: Styles.BODY_STYLE),
                  SizedBox(height: 12),
                  Text(
                    Strings.STATUS,
                    style: Styles.PRIMARY_HEADING,
                  ),
                  Text(project.status!, style: Styles.BODY_STYLE),
                  SizedBox(height: 12),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  String parse(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }
}
