import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nasa/application/projects/projects_cubit.dart';
import 'package:nasa/application/projects/projects_state.dart';
import 'package:nasa/application/theme/theme_cubit.dart';
import 'package:nasa/presentation/home/pages/projects/widgets/project_widget.dart';
import 'package:nasa/util/ui/nasa_colors.dart';
import 'package:nasa/util/ui/strings.dart';
import 'package:nasa/util/ui/text_styles.dart';
import 'package:nasa/util/ui/ui_constants.dart';

import '../../../../application/projects/projects_cubit.dart';
import '../../../../application/projects/projects_state.dart';
import '../../../../injection_container.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  ScrollController? _controller;

  DateTime date = DateTime.now().subtract(Duration(days: 15));

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>();
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification &&
              _controller!.position.extentAfter == 0) {
            date = date.subtract(Duration(days: 1));
            if (context.read<ProjectsCubit>().state is ProjectsCompleted) {
              context
                  .read<ProjectsCubit>()
                  .fetchProjects(DateFormat("yyyy-MM-dd").format(date));
            }
          }
          return false;
        },
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
                      text: "${Strings.LATEST}\n",
                      style: DARK_MODE
                          ? Styles.F1TITLE_STYLE
                          : Styles.TITLE_STYLE),
                  TextSpan(
                      text: Strings.PROJECTS,
                      style: DARK_MODE
                          ? Styles.F1HEADING_STYLE
                          : Styles.HEADING_STYLE)
                ]),
              ),
            ),
            StreamBuilder(
                stream: context.watch<ProjectsCubit>().projectsStream,
                builder: (conntext, snapshot) {
                  if (snapshot.hasData) {
                    final List projects = snapshot.data as List;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: projects.length,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return index >= projects.length
                            ? ProjectLoadingWidget()
                            : ProjectWidget(project: projects[index]);
                      },
                    );
                  } else {
                    final List projects = List.generate(10, (index) => null);
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: projects.length,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return ProjectLoadingWidget();
                      },
                    );
                  }
                }),
            // BlocBuilder<ProjectsCubit, ProjectsState>(
            //     builder: (context, state) {
            //   if (state is ProjectsCompleted) {
            //     final projects = state.projects;
            //     return Column(
            //         children: projects
            //             .map((project) =>
            //                 ProjectWidget(project: project))
            //             .toList());
            //   } else if (state is ProjectsLoading) {
            //     return Column(
            //         children: List.generate(
            //             30, (index) => ProjectLoadingWidget()));
            //   } else {
            //     return Container();
            //   }
            // })
          ],
        ),
      ),
    );
  }
}
