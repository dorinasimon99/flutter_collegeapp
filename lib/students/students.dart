import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_cubit.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentsPage extends StatefulWidget {
  CourseData? course;
  StudentsPage({this.course});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.course != null){
      BlocProvider.of<UserCoursesCubit>(context)..getUserCoursesByCourseCode(widget.course!.courseCode);
    }
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      '${widget.course!.name} ${AppLocalizations.of(context)?.students ?? 'students'}',
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 35),
                    ),
                  ),
                ],
              ),
              BlocListener<UserCoursesCubit, UserCoursesState>(
                listener: (context, state){
                  if(state is ListUserCoursesSuccess){
                    var usernames = <String>[];
                    for(var userCourse in state.userCourses){
                      usernames.add(userCourse.username);
                    }
                    BlocProvider.of<UsersCubit>(context)..getStudents(usernames);
                  }
                },
                child: Container(),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: BlocBuilder<UsersCubit, UsersState>(
                    builder: (context, state){
                      if(state is ListStudentsSuccess){
                        state.users..sort((a, b){
                          return a.name.compareTo(b.name);
                        });
                        return ListView(
                          shrinkWrap: true,
                          children: state.users.map((student) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Image.asset("assets/avatar.png", width: 30,),
                                ),
                                Text(
                                  student.name,
                                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                          )).toList(),
                        );
                      } else if(state is ListStudentsFailure){
                        return Center(child: Text(state.exception.toString()));
                      } else {
                        return LoadingView();
                      }
                    },
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
