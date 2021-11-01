import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/courses/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/lesson/lesson_cubit.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/TodoData.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../app.dart';


class TimetablePage extends StatefulWidget {

  TimetablePage();

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  _TimetablePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isMenu: false),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              Expanded(
                child: BlocProvider(
                    create: (context) => LessonsCubit()..getLessons(),
                    child: BlocBuilder<LessonsCubit, LessonsState>(builder: (context, state) {
                      if (state is ListLessonsSuccess) {
                        var lessons = state.lessons;
                        return BlocProvider(
                          create: (context) => TodosCubit()..getTodosWithDeadline(),
                          child: BlocBuilder<TodosCubit, TodosState>(
                            builder: (context, state) {
                              if (state is ListTodosSuccess) {
                                return SfCalendar(
                                    view: CalendarView.week,
                                    firstDayOfWeek: 1,
                                    timeSlotViewSettings: TimeSlotViewSettings(
                                      startHour: 7,
                                      endHour: 21,
                                      nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                                    ),
                                    dataSource: MeetingDataSource(_getDataSource(lessons, todos: state.todos)),
                                    todayHighlightColor: Color(0xFF9FC2A0),
                                    headerStyle: CalendarHeaderStyle(backgroundColor: Color(0xFFB4E7B6)),
                                    viewHeaderStyle: ViewHeaderStyle(backgroundColor: Color(0xFFB4E7B6)),
                                    appointmentTextStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 12, color: Colors.black),
                                    onTap: (CalendarTapDetails details) =>
                                        details.appointments != null && !details.appointments![0].isAllDay
                                            ? Navigator.pushNamed(
                                                context, 'lesson',
                                                arguments: lessons.firstWhere((element) =>
                                                element.title == details.appointments![0].eventName))
                                            : {});
                              } else if (state is ListTodosFailure) {
                                return SfCalendar(
                                    view: CalendarView.week,
                                    firstDayOfWeek: 1,
                                    timeSlotViewSettings: TimeSlotViewSettings(
                                      startHour: 7,
                                      endHour: 21,
                                      nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                                    ),
                                    dataSource: MeetingDataSource(_getDataSource(lessons)),
                                    todayHighlightColor: Color(0xFF9FC2A0),
                                    headerStyle: CalendarHeaderStyle(backgroundColor: Color(0xFFB4E7B6)),
                                    viewHeaderStyle: ViewHeaderStyle(backgroundColor: Color(0xFFB4E7B6)),
                                    appointmentTextStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 12, color: Colors.black),
                                    onTap: (CalendarTapDetails details) =>
                                        details.appointments != null
                                            ? Navigator.pushNamed(context, 'lesson', arguments: lessons.firstWhere(
                                                    (element) => element.title == details.appointments![0].eventName))
                                            : {});
                              } else {
                                return LoadingView();
                              }
                            },
                          ),
                        );
                      } else if (state is ListLessonsFailure) {
                        return Center(child: Text(state.exception.toString()));
                      } else {
                        return LoadingView();
                      }
                    })
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: homeButton(context),
              )]
            )
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
      meetings.add(Meeting(element.title, startTime, endTime, const Color(0xFFB4E7B6), false, ""));
    });
    if(todos != null){
      todos.forEach((element) {
        DateTime startTime = DateTime(int.parse(element.deadline!.split(".")[0]),
            int.parse(element.deadline!.split(".")[1]), int.parse(element.deadline!.split(".")[2]));
        DateTime endTime = DateTime(int.parse(element.deadline!.split(".")[0]),
            int.parse(element.deadline!.split(".")[1]), int.parse(element.deadline!.split(".")[2]));
        meetings.add(Meeting(element.name, startTime, endTime, element.done ? const Color(
            0xFFC9C9C9) : const Color(
            0xFFADCBAD), true, ""));
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
