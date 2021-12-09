import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/courses/courses_cubit.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String? currentUsername;
  String? currentName;
  int? currentUserSemester;
  List<CourseData> _courses = [];

  void getUserCourses() async {
    currentName = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    currentUsername = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    currentUserSemester = await LocalStorage.localStorage.readInt(LocalStorage.SIGNED_IN_SEMESTER);
    if(currentUsername != null){
      BlocProvider.of<CoursesCubit>(context)..getActualSemesterCourses(currentUsername!, currentUserSemester);
    }
  }

  @override
  void initState(){
    getUserCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      bottomNavigationBar: HomeButton(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<UsersCubit, UsersState>(
                  listener: (context, state){
                    if(state is UpdateUserSuccess){
                      getUserCourses();
                    }
                  },
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)?.my_courses ?? 'My courses',
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'addCourse', arguments: [currentUsername, currentName, currentUserSemester]),
                    child: Text(
                      "+",
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                    ),
                  )
                ],
              ),
              Expanded(
                child: BlocListener<CoursesCubit, CoursesState>(
                    listener: (context, state) {
                      if (state is ListActualSemesterCoursesSuccess) {
                        setState(() {
                          _courses = state.courses;
                        });
                      } else if (state is DeleteCourseSuccess) {
                        BlocProvider.of<CoursesCubit>(context)..getActualSemesterCourses(currentUsername!, currentUserSemester);
                      } else if (state is UpdateCourseSuccess){
                        BlocProvider.of<CoursesCubit>(context)..getActualSemesterCourses(currentUsername!, currentUserSemester);
                      } else if (state is CreateCourseSuccess){
                        BlocProvider.of<CoursesCubit>(context)..getActualSemesterCourses(currentUsername!, currentUserSemester);
                      }
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: _courses.map((course) => AllCourseItem(course: course, username: currentUsername)).toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllCourseItem extends StatelessWidget {
  final CourseData course;
  final String? username;
  AllCourseItem({required this.course, this.username});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'courseDetails', arguments: [course, username]),
      child: Card(
        color: Resources.customColors.cardGreen,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      course.name,
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.courseCode,
                    style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    course.credits.toString(),
                    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

