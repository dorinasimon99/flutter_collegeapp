import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/home/today_lessons_list.dart';
import 'package:flutter_collegeapp/lesson/lesson_cubit.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CourseData> _todayCourses = <CourseData>[];

  @override
  Widget build(BuildContext context) {
    return todayCoursesView(context, _todayCourses);
  }
}

Widget todayCoursesView(BuildContext context, List<CourseData> _todayCourses) {
  String date = DateFormat('yyyy.M.d.').format(DateTime.now());
  BlocProvider.of<LessonsCubit>(context)..getTodayLessons(date);
  return Scaffold(
    appBar: header(context),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.today ?? 'Today',
              style: TextStyle(
                  fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
            ),
            BlocBuilder<LessonsCubit, LessonsState>(
                builder: (context, state) {
                  if(state is ListLessonsSuccess) {
                    return  TodayLessonsList(
                        lessons: state.lessons..sort((a, b) {
                            return a.time.compareTo(b.time);
                          }));
                  } else if (state is ListLessonsFailure) {
                    return Center(child: Text(state.exception.toString()));
                  } else {
                    return LoadingView();
                  }
                },
              ),
          ],
        ),
      ),
    ),
  );
}


