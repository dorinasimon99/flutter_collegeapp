import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/home/today_lessons_list.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/UserCourse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app.dart';

class LessonsList extends StatefulWidget {

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  String? localUser;
  String? localRole;
  String? localName;
  CourseData? course;
  bool getDataDone = false;

  void _getData(CourseData courseData) async {
    var localUsername = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    var localUserName = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    var localUserRole = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    setState(() {
      course = courseData;
      localUser = localUsername;
      localRole = localUserRole;
      localName = localUserName;
      getDataDone = true;
    });
    BlocProvider.of<LessonsCubit>(context)..getCourseLessons(course?.courseCode);
  }

  @override
  Widget build(BuildContext context) {
    CourseData? args = ModalRoute.of(context)!.settings.arguments as CourseData?;
    if(!getDataDone && args != null){
      _getData(args);
    }
    return Scaffold(
      appBar: Header(context, isMenu: false),
      bottomNavigationBar: HomeButton(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "${course?.name} ${AppLocalizations.of(context)?.lessons ?? 'Lessons'}",
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 35),
                  ),
                ),
                localRole != null && localRole == Roles.instance.student ? Container() : TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'addLesson', arguments: [UserCourse(name: localName!, courseCode: course!.courseCode, username: localUser!), null]),
                  child: Text(
                    "+",
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                  ),
                )
              ],
            ),
            BlocBuilder<LessonsCubit, LessonsState>(
                builder: (context, state) {
                  if (state is ListCourseLessonsSuccess) {
                    if(getDataDone && state.lessons.isNotEmpty){
                      return ListView(
                        shrinkWrap: true,
                        children: state.lessons
                            .map((lesson) => LessonItem(lesson: lesson, localUser: localUser))
                            .toList(),
                      );
                    } else{
                      return Text(
                          AppLocalizations.of(context)?.no_results ?? "No results"
                      );
                    }
                  } else if(state is ListCourseLessonsFailure){
                    return Center(child: Text(state.exception.toString()));
                  } else return LoadingView();
                }
            ),
          ],
        ),
      ),
    );
  }
}