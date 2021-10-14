import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/courses/CoursesCubit.dart';
import 'package:flutter_collegeapp/home/today_courses_list.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pushNamed(context, 'menu'),
        icon: Image.asset('assets/hamburger.png'),
        iconSize: 120,
      ),
      toolbarHeight: 100.0,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
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
            BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if(state is ListCoursesSuccess) {
                  return  TodayCoursesList(
                      courses: state.courses
                        ..sort((a, b) {
                          return a.time.compareTo(b.time);
                        }));
                } else if (state is ListCoursesFailure) {
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


