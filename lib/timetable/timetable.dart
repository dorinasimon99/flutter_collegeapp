import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/courses/CoursesCubit.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../app.dart';


class TimetablePage extends StatefulWidget {

  TimetablePage();

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  _TimetablePageState();
  String today = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        child: BlocProvider(
          create: (context) => CoursesCubit()..getCourses(),
          child: BlocBuilder<CoursesCubit, CoursesState>(
            builder: (context, state) {
              if(state is ListCoursesSuccess) {
                return  SfCalendar(
                  view: CalendarView.week,
                  firstDayOfWeek: 1,
                  timeSlotViewSettings: TimeSlotViewSettings(
                    startHour: 7,
                    endHour: 21,
                    nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
                  ),

                  dataSource: MeetingDataSource(_getDataSource(state.courses)),
                  todayHighlightColor: Color(0xFF9FC2A0),
                  headerStyle: CalendarHeaderStyle(
                      backgroundColor: Color(0xFFB4E7B6)
                  ),
                  viewHeaderStyle: ViewHeaderStyle(
                      backgroundColor: Color(0xFFB4E7B6)
                  ),
                );
              } else if (state is ListCoursesFailure) {
                return Center(child: Text(state.exception.toString()));
              } else {
                return LoadingView();
              }
            },
          ),
        ),
      ),
    );
  }
  List<Meeting> _getDataSource(List<CourseData> courses) {
    final List<Meeting> meetings = <Meeting>[];
    courses.forEach((element) {
      String from = element.time.split(" ")[1].split("-")[0];
      String to = element.time.split(" ")[1].split("-")[1];
      DateTime startTime = DateTime(2021, 9, 6, int.parse(from.split(":")[0]), int.parse(from.split(":")[1]), 0);
      DateTime endTime = DateTime(2021, 9, 6, int.parse(to.split(":")[0]), int.parse(to.split(":")[1]), 0);
      String weekDayCode = getWeekdayCode(element);
      meetings.add(Meeting(element.name, startTime, endTime, const Color(0xFFB4E7B6), false, 'FREQ=WEEKLY;BYDAY='+weekDayCode+';INTERVAL=1;COUNT=14'));
    });
    return meetings;
  }

  String getWeekdayCode(CourseData data){
    switch(data.time.split(" ")[0]){
      case "Monday": return "MO";
      case "Tuesday": return "TU";
      case "Wednesday": return "WE";
      case "Thursday": return "TH";
      case "Friday": return "FR";
      case "Saturday": return "SA";
      case "Sunday": return "SU";
      default: return "MO";
    }
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
