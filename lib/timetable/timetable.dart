import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/TodoData.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app.dart';


class TimetablePage extends StatefulWidget {

  TimetablePage();

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  _TimetablePageState();
  List<LessonData> _lessons = <LessonData>[];
  List<TodoData>? _todos;
  String? _localUsername;
  String? _localName;
  int? _localSemester;

  void _getUser() async {
    var username = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    var name = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    var actualSemester = await LocalStorage.localStorage.readInt(LocalStorage.SIGNED_IN_SEMESTER);
    if(username != null && name != null && actualSemester != null){
      setState(() {
        _localUsername = username;
        _localName = name;
        _localSemester = actualSemester;
      });
      BlocProvider.of<LessonsCubit>(context)..getUserLessons(username, actualSemester);
    }

  }

  @override
  void initState(){
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(context, isMenu: false),
        bottomNavigationBar: HomeButton(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)?.timetable ?? 'Timetable',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocListener<TodosCubit, TodosState>(
                    listener: (context, state) {
                      if (state is ListTodosWithDeadlineSuccess) {
                        setState(() {
                          _todos = state.todos;
                        });
                      } else if(state is ListTodosWithDeadlineFailure){
                        showErrorAlert(state.exception.toString(), context);
                      }
                    },
                    child: SfCalendar(
                              view: CalendarView.week,
                              firstDayOfWeek: 1,
                              timeSlotViewSettings: TimeSlotViewSettings(
                                startHour: 7,
                                endHour: 21,
                                nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                              ),
                              dataSource: MeetingDataSource(
                                  _getDataSource(_lessons, todos: _todos)),
                              todayHighlightColor: Color(0xFF9FC2A0),
                              headerStyle:
                                  CalendarHeaderStyle(backgroundColor: Resources.customColors.cursorGreen),
                              viewHeaderStyle:
                                  ViewHeaderStyle(backgroundColor: Resources.customColors.cursorGreen),
                              appointmentTextStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 12),
                              onTap: (CalendarTapDetails details) =>
                                  details.appointments != null &&
                                          !details.appointments![0].isAllDay
                                      ? Navigator.pushNamed(context, 'lesson',
                                          arguments: _lessons.firstWhere((element) =>
                                              element.title ==
                                              details.appointments![0].eventName))
                                      : {}),


              ),
            ),
            BlocListener<LessonsCubit, LessonsState>(
                listener: (context, state) {
                  if (state is CreateLessonSuccess) {
                    BlocProvider.of<LessonsCubit>(context)..getUserLessons(_localUsername!, _localSemester!);
                  } else if (state is ListUserLessonsSuccess) {
                    setState(() {
                      _lessons = state.lessons;
                    });
                    BlocProvider.of<TodosCubit>(context)
                      ..getTodosWithDeadline(_localUsername!);
                  } else if(state is CreateLessonFailure){
                    showErrorAlert(state.exception.toString(), context);
                  } else if(state is ListUserLessonsFailure){
                    showErrorAlert(state.exception.toString(), context);
                  } else if(state is UpdateLessonSuccess){
                    BlocProvider.of<LessonsCubit>(context)..getUserLessons(_localUsername!, _localSemester!);
                  } else if(state is UpdateLessonFailure){
                    showErrorAlert(state.exception.toString(), context);
                  }
                },
                child: Container()),
          ]),
        )
    );
  }

  List<Meeting> _getDataSource(List<LessonData> lessons, {List<TodoData>? todos}) {
    final List<Meeting> meetings = <Meeting>[];
    lessons.forEach((element) {
      String from = element.time.split("-")[0];
      String to = element.time.split("-")[1];
      DateTime startTime = DateTime(int.parse(element.date.split(".")[0]),
          int.parse(element.date.split(".")[1]), int.parse(element.date.split(".")[2]),
          int.parse(from.split(":")[0]), int.parse(from.split(":")[1]), 0);
      DateTime endTime = DateTime(int.parse(element.date.split(".")[0]),
          int.parse(element.date.split(".")[1]), int.parse(element.date.split(".")[2]),
          int.parse(to.split(":")[0]), int.parse(to.split(":")[1]), 0);
      meetings.add(Meeting(element.title, startTime, endTime, Resources.customColors.cursorGreen, false, ""));
    });
    if(todos != null){
      todos.forEach((element) {
        if(element.deadline != null){
          DateTime startTime = DateTime(int.parse(element.deadline!.split(".")[0]),
              int.parse(element.deadline!.split(".")[1]), int.parse(element.deadline!.split(".")[2]));
          DateTime endTime = DateTime(int.parse(element.deadline!.split(".")[0]),
              int.parse(element.deadline!.split(".")[1]), int.parse(element.deadline!.split(".")[2]));
          meetings.add(Meeting(element.name, startTime, endTime, element.done ?
            Resources.customColors.todoDone : Resources.customColors.todoGreen, true, ""));
        }
      });
    }
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getRecurrenceRule(int index) {
    return appointments![index].recurrenceRule;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay, this.recurrenceRule);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? recurrenceRule;
}
