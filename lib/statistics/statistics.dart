import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/bloc/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_cubit.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String? _localUsername;
  String? _localUserRole;
  int? _localSemester;
  List<CourseData> _courses = <CourseData>[];
  List<UserCourse> _userCourses = <UserCourse>[];
  List<Tab> _tabs = <Tab>[];
  List<StatisticItem> _tabContent = <StatisticItem>[];

  void _getLocalUser() async {
    _localUsername = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    _localUserRole = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    _localSemester = await LocalStorage.localStorage.readInt(LocalStorage.SIGNED_IN_SEMESTER);
    BlocProvider.of<UserCoursesCubit>(context)..getUserCourses();

  }

  @override
  void initState(){
    _getLocalUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.statistics ?? 'Statistics',
              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
            ),
            BlocListener<UserCoursesCubit, UserCoursesState>(
              listener: (context, state) {
                if (state is ListUserCoursesSuccess) {
                  setState(() {
                    _userCourses = state.userCourses;
                  });
                  if(_localUsername != null){
                    BlocProvider.of<CoursesCubit>(context)..getUserCourses(_localUsername!);
                  }
                }},
              child: Container()
            ),
            BlocListener<CoursesCubit, CoursesState>(
                listener: (context, state) {
                  if (state is ListUsersCoursesSuccess) {
                    setState(() {
                      _courses = state.courses;
                    });
                    _localUserRole == Roles.instance.teacher ? _getTeacherStatistics() : _getStudentStatistics();
                  }},
                child: Container()
            ),
            Flexible(
              child:  BlocBuilder<CoursesCubit, CoursesState>(
                builder: (context, state) {
                  if (state is ListUsersCoursesSuccess) {
                    return DefaultTabController(
                      length: _tabs.length,
                      child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            flexibleSpace: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  indicatorColor:
                                  Resources.customColors.cursorGreen,
                                  labelColor: Colors.black,
                                  labelStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                                  tabs: _tabs,
                                )
                              ],
                            ),
                            automaticallyImplyLeading: false,
                          ),
                          body: TabBarView(
                            children: _tabContent,
                          )
                      ),
                    );
                  } else if(state is ListUsersCoursesFailure){
                    return Center(child: Text(state.exception.toString()));
                  } else return LoadingView();
                  },
              ),
            ),
          ]
        )
      )
    );
  }

  void _getStudentStatistics(){

    _tabs.add(Tab(text: AppLocalizations.of(context)?.semesters_index ?? 'Semesters indexes'));
    _tabs.add(Tab(text: AppLocalizations.of(context)?.semesters_credits ?? 'Semesters credits'));

    List<int> _semesters = [];

    for(var userCourse in _userCourses){
      if(userCourse.semester != null && !_semesters.contains(userCourse.semester) && _localSemester != null && userCourse.semester! < _localSemester!) {
        _semesters.add(userCourse.semester!);
      }
    }

    List<ChartData> _indexChartDatas = [];
    List<ChartData> _creditChartDatas = [];

    for(var semester in _semesters){
      var userCourses = <UserCourse>[];
      _userCourses.forEach((element) {
        if(element.semester != null && element.semester == semester && element.username == _localUsername){
          userCourses.add(element);
        }
      });
      double index = 0;
      int gradeXcredit = 0;
      int sumCredit = 0;
      for(var userCourse in userCourses){
        if(userCourse.grade != null){
          var course = _courses.firstWhere((element) => element.courseCode == userCourse.courseCode);
          gradeXcredit += userCourse.grade! * course.credits;
          sumCredit += course.credits;
        }
      }
      index = gradeXcredit / sumCredit;
      _indexChartDatas.add(ChartData(index: index, semester: semester));
      _creditChartDatas.add(ChartData(credit: sumCredit, semester: semester));
    }

    _tabContent.add(StatisticItem(chartDatas: _indexChartDatas));
    _tabContent.add(StatisticItem(chartDatas: _creditChartDatas));

  }

  void _getTeacherStatistics(){

    _tabs.add(Tab(text: AppLocalizations.of(context)?.courses_students ?? 'Course students'));
    _tabs.add(Tab(text: AppLocalizations.of(context)?.courses_ratings ?? 'Course ratings'));

    List<ChartData> _studentsChartDatas = [];
    List<ChartData> _ratingsChartDatas = [];

    for(var course in _courses){
      var userCourses = <UserCourse>[];
      _userCourses.forEach((element) {
        if(element.courseCode == course.courseCode){
          userCourses.add(element);
        }
      });
      double rating = 0;
      int students = 0;
      for(var userCourse in userCourses){
        if(userCourse.username == _localUsername && userCourse.rating != null){
          rating = double.parse(userCourse.rating!);
        } else if(userCourse.username != _localUsername && userCourse.semester != null && course.teachers != null && !course.teachers!.contains(userCourse.name)){
          students++;
        }
      }
      _studentsChartDatas.add(ChartData(student: students, course: course.name));
      _ratingsChartDatas.add(ChartData(rating: rating, course: course.name));
    }

    _tabContent.add(StatisticItem(chartDatas: _studentsChartDatas));
    _tabContent.add(StatisticItem(chartDatas: _ratingsChartDatas));

  }
}

class ChartData {
  double? index;
  int? credit;
  int? student;
  double? rating;
  int? semester;
  String? course;

  ChartData({this.index, this.credit, this.student, this.rating, this.semester, this.course});

}

class StatisticItem extends StatefulWidget {
  final List<ChartData> chartDatas;
  StatisticItem({required this.chartDatas});

  @override
  _StatisticItemState createState() => _StatisticItemState();
}

class _StatisticItemState extends State<StatisticItem> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelStyle: Resources.customTextStyles.getCustomTextStyle(fontSize: 18),
          maximumLabelWidth: 50.0
        ),
        primaryYAxis: NumericAxis(
          labelStyle: Resources.customTextStyles.getCustomTextStyle(fontSize: 18),
        ),
        tooltipBehavior: _tooltipBehavior,
        series: <ColumnSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
              dataSource: widget.chartDatas,
              xValueMapper: (ChartData data, _) => '${data.semester ?? data.course}',
              yValueMapper: (ChartData data, _) => data.index ?? data.credit ?? data.student ?? data.rating,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              color: Resources.customColors.cursorGreen,
          )
        ],
      ),
    );
  }
}

