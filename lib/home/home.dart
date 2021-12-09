import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/home/today_lessons_list.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/UserData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  String? name;
  int? semester;
  String date = DateFormat('yyyy.M.dd.').format(DateTime.now());
  List<LessonData> _lessons = [];

  void _getLocalUser() async {
    await Amplify.DataStore.start();
    var localUsername = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    if(localUsername != null){
      setState(() {
        username = localUsername;
      });
      BlocProvider.of<UsersCubit>(context)..getUserByUsername(localUsername);
    }

  }

  @override
  void initState(){
    super.initState();
    _getLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<UsersCubit, UsersState>(
                listener: (context, state) {
                  if(state is GetUserSuccess){
                    _saveUser(state.user);
                    BlocProvider.of<LessonsCubit>(context)..getTodayLessons(state.user.username, state.user.actualSemester, date);
                  } else if (state is GetUserFailure){
                    showErrorAlert(state.exception.toString(), context);
                  } else if(state is UpdateUserSuccess){
                    BlocProvider.of<LessonsCubit>(context)..getTodayLessons(state.user.username, state.user.actualSemester, date);
                  } else if (state is UpdateUserFailure){
                    showErrorAlert(state.exception.toString(), context);
                  }
                },
                child: Container(),
              ),
              Text(
                AppLocalizations.of(context)?.today ?? 'Today',
                style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
              ),
              BlocListener<LessonsCubit, LessonsState>(
                listener: (context, state){
                  if(state is CreateLessonSuccess){
                    BlocProvider.of<LessonsCubit>(context)..getTodayLessons(username!, semester, date);
                  } else if (state is ListTodayLessonsSuccess){
                    setState(() {
                      _lessons = state.lessons;
                    });
                  } else if(state is CreateLessonFailure){
                    showErrorAlert(state.exception.toString(), context);
                  } else if(state is ListTodayLessonsFailure){
                    showErrorAlert(state.exception.toString(), context);
                  } else if(state is ListUserLessonsSuccess){
                    BlocProvider.of<LessonsCubit>(context)..getTodayLessons(username!, semester, date);
                  } else if(state is UpdateLessonSuccess){
                    BlocProvider.of<LessonsCubit>(context)..getTodayLessons(username!, semester, date);
                  }
                },
                child: Container(),
              ),
              BlocBuilder<LessonsCubit, LessonsState>(
                  builder: (context, state){
                    if (state is ListTodayLessonsSuccess){
                      return TodayLessonsList(
                          lessons: _lessons..sort((a, b) {
                        return a.time.compareTo(b.time);
                      }), localUser: username);
                    } else {
                      return Container();
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveUser(UserData user) async {
    await LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_ROLE, user.role);
    await LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_NAME, user.name);
    await LocalStorage.localStorage.saveInt(LocalStorage.SIGNED_IN_SEMESTER, user.actualSemester);
    setState(() {
        semester = user.actualSemester;
        name = user.name;
    });
  }
}