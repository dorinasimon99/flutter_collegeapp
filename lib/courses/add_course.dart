import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/days.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/bloc/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numberpicker/numberpicker.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({Key? key}) : super(key: key);

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  String _currentDayValue = Days.instance.days[0];
  int _currentCreditsValue = 0;
  int _currentStartHour = 8;
  int _currentStartMinute = 15;
  int _currentEndHour = 10;
  int _currentEndMinute = 0;
  var _courseNameTextController = TextEditingController();
  var _courseCodeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CourseData? selectedCourse;
  String? _localUsername;
  String? _localName;
  String? _localRole;
  int? _localUserSemester;
  var _allCourses = <CourseData>[];

  void _getUser() async {
    var username = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    var name = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    var role = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    var semester = await LocalStorage.localStorage.readInt(LocalStorage.SIGNED_IN_SEMESTER);
    if(username != null && name != null && role != null && semester != null){
      setState(() {
        _localUsername = username;
        _localName = name;
        _localUserSemester = semester;
        _localRole = role;
      });
    }
    BlocProvider.of<CoursesCubit>(context)..getCourses();
  }

  @override
  void initState(){
    super.initState();
    _getUser();
  }

  @override
  void dispose(){
    _courseCodeTextController.dispose();
    _courseNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Object?> args = ModalRoute.of(context)?.settings.arguments as List<Object?>;
    _localUsername = args[0] as String;
    _localName = args[1] as String;
    _localUserSemester = args[2] as int;
    return Scaffold(
        appBar: Header(context, isMenu: false),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            AppLocalizations.of(context)?.add_course ?? 'Add course',
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                        ),
                        BlocListener<CoursesCubit, CoursesState>(
                          listener: (context, state) {
                            if(state is CreateCourseSuccess){
                              showSnackBar(context, AppLocalizations.of(context)?.course_added ?? 'Course added');
                            } else if(state is UpdateCourseSuccess){
                              showSnackBar(context, AppLocalizations.of(context)?.course_added ?? 'Course added');
                            } else if(state is CreateCourseFailure){
                              showErrorAlert(state.exception.toString(), context);
                            } else if(state is UpdateCourseFailure){
                              showErrorAlert(state.exception.toString(), context);
                            }
                          },
                          child: IconButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()){
                                _saveCourse(context);
                              }
                            },
                            icon: Icon(Icons.check, color: Color(0xFFA5D6A7), size: 45),
                          ),
                        )
                      ],
                    ),
                    BlocListener<CoursesCubit, CoursesState>(
                      listener: (context, state) {
                        if(state is ListCoursesSuccess){
                          setState(() {
                            _allCourses = state.courses;
                          });
                        } else if(state is ListCoursesFailure){
                          showErrorAlert(state.exception.toString(), context);
                        }
                      },
                      child: TextButton(
                        onPressed: () => _showSelectCourseDialog(_allCourses),
                        child: Text(
                          AppLocalizations.of(context)?.select_from_list ?? 'Select from list...',
                          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                      child: TextFormField(
                        controller: _courseNameTextController,
                        enabled: (_localRole != null && _localRole == Roles.instance.teacher) || selectedCourse == null,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)?.course_name ?? 'Course name',
                          hintStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 18, color: Color(0xFF4F4F4F)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Resources.customColors.cardGreen
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Resources.customColors.cardGreen
                              )
                          ),
                        ),
                        cursorColor: Resources.customColors.cardGreen,
                        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                          } else return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      child: TextFormField(
                        controller: _courseCodeTextController,
                        enabled: (_localRole != null && _localRole == Roles.instance.teacher) || selectedCourse == null,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)?.course_code ?? 'Course code',
                          hintStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 18, color: Color(0xFF4F4F4F)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Resources.customColors.cardGreen
                              )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Resources.customColors.cardGreen
                              )
                          ),
                        ),
                        cursorColor: Resources.customColors.cardGreen,
                        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                          } else if(selectedCourse == null && _allCourses.isNotEmpty && _allCourses.any((element) => element.courseCode == value)){
                            return AppLocalizations.of(context)?.existing_courseCode ?? 'This course code already exist!';
                          } else return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberPicker(
                          itemHeight: 40,
                          minValue: 0,
                          maxValue: 4,
                          onChanged: (value) => (_localRole != null && _localRole == Roles.instance.teacher) || selectedCourse == null ? setState(() {
                            _currentDayValue = Days.instance.days[value];
                          }) : (){},
                          textMapper: (numberText) {
                            switch(numberText){
                              case "0": return AppLocalizations.of(context)?.monday ?? Days.instance.days[0];
                              case "1": return AppLocalizations.of(context)?.tuesday ?? Days.instance.days[1];
                              case "2": return AppLocalizations.of(context)?.wednesday ?? Days.instance.days[2];
                              case "3": return AppLocalizations.of(context)?.thursday ?? Days.instance.days[3];
                              case "4": return AppLocalizations.of(context)?.friday ?? Days.instance.days[4];
                              default: return "";
                            }
                          },
                          value: Days.instance.days.indexOf(_currentDayValue),
                          selectedTextStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                          textStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 14, color: Color(0xFF4F4F4F)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: (_localRole != null && _localRole == Roles.instance.teacher) || selectedCourse == null ? TimePicker(
                          context, _currentStartHour, _currentStartMinute, _currentEndHour, _currentEndMinute,
                              (value){setState(() {_currentStartHour = value;});},
                              (value){setState(() {_currentStartMinute = value;});},
                              (value){setState(() {_currentEndHour = value;});},
                              (value){setState(() {_currentEndMinute = value;});}
                      ) : TimePicker(
                          context, _currentStartHour, _currentStartMinute, _currentEndHour, _currentEndMinute,
                              (value){},
                              (value){},
                              (value){},
                              (value){}
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.credits ?? 'Credits:',
                            style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () => (_localRole != null && _localRole == Roles.instance.teacher) || selectedCourse == null ? setState(() {
                              _currentCreditsValue--;
                            }) : (){},
                            child: Text(
                              "-",
                              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                            ),
                          ),
                          Text(
                            _currentCreditsValue.toString(),
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                          ),
                          TextButton(
                            onPressed: () => (_localRole != null && _localRole == Roles.instance.teacher) || selectedCourse == null ? setState(() {
                              _currentCreditsValue++;
                            }) : (){},
                            child: Text(
                              "+",
                              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _saveCourse(BuildContext context) async {
    var localUserRole = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    var saveCourse;
    if(selectedCourse != null){
      if(localUserRole != null && _localName != null){
        if(localUserRole == Roles.instance.teacher){
          if(selectedCourse?.teachers == null){
            saveCourse = CourseData(
                id: selectedCourse!.id,
                name: _courseNameTextController.text,
                credits: _currentCreditsValue,
                time: '$_currentDayValue $_currentStartHour:${addZero(_currentStartMinute)}-$_currentEndHour:${addZero(_currentEndMinute)}',
                courseCode: _courseCodeTextController.text,
                teachers: [_localName!]
            );
          } else {
            selectedCourse?.teachers?.add(_localName!);
            saveCourse = CourseData(
                id: selectedCourse!.id,
                name: _courseNameTextController.text,
                credits: _currentCreditsValue,
                time: '$_currentDayValue $_currentStartHour:${addZero(_currentStartMinute)}-$_currentEndHour:${addZero(_currentEndMinute)}',
                courseCode: _courseCodeTextController.text,
                teachers: selectedCourse!.teachers
            );
          }
          BlocProvider.of<CoursesCubit>(context)..updateCourse(_localUsername!, _localUserSemester!, _localName!, selectedCourse!.courseCode, saveCourse);
        } else {
          saveCourse = CourseData(
              id: selectedCourse!.id,
              name: _courseNameTextController.text,
              credits: _currentCreditsValue,
              time: '$_currentDayValue $_currentStartHour:${addZero(_currentStartMinute)}-$_currentEndHour:${addZero(_currentEndMinute)}',
              courseCode: _courseCodeTextController.text
          );
          BlocProvider.of<CoursesCubit>(context)..updateCourse(_localUsername!, _localUserSemester!, _localName!, selectedCourse!.courseCode, saveCourse);
        }
      }
    } else {
      var course = CourseData(
          courseCode: _courseCodeTextController.text,
          name: _courseNameTextController.text,
          credits: _currentCreditsValue,
          time: "$_currentDayValue $_currentStartHour:${addZero(_currentStartMinute)}-$_currentEndHour:${addZero(_currentEndMinute)}");
      if(localUserRole != null && _localName != null && _localUsername != null){
        if(localUserRole == Roles.instance.teacher){
          saveCourse = course.copyWith(teachers: [_localName!]);
          BlocProvider.of<CoursesCubit>(context)..createCourse(_localUsername!, _localName!, _localUserSemester!, saveCourse);
        } else {
          BlocProvider.of<CoursesCubit>(context)..createCourse(_localUsername!, _localName!, _localUserSemester!, course);
        }
      }
    }

    _courseNameTextController.text = '';
    _courseCodeTextController.text = '';
    _currentDayValue = Days.instance.days[0];
    _currentCreditsValue = 0;
    _currentStartHour = 8;
    _currentStartMinute = 15;
    _currentEndHour = 10;
    _currentEndMinute = 0;
  }

  void _showSelectCourseDialog(List<CourseData> courses) async {
    var _selectedCourse = await Navigator.pushNamed(context, 'searchCourse', arguments: courses) as CourseData?;

    if(_selectedCourse != null){
      setState(() {
        _courseNameTextController.text = _selectedCourse.name;
        _courseCodeTextController.text = _selectedCourse.courseCode;
        _currentDayValue = _selectedCourse.time.split(" ")[0];
        _currentCreditsValue = _selectedCourse.credits;
        _currentStartHour = int.parse(_selectedCourse.time.split(" ")[1].split("-")[0].split(":")[0]);
        _currentStartMinute = int.parse(_selectedCourse.time.split(" ")[1].split("-")[0].split(":")[1]);
        _currentEndHour = int.parse(_selectedCourse.time.split(" ")[1].split("-")[1].split(":")[0]);
        _currentEndMinute = int.parse(_selectedCourse.time.split(" ")[1].split("-")[1].split(":")[1]);
        selectedCourse = _selectedCourse;
      });
    }
  }
}
