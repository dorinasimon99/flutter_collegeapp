import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/days.dart';
import 'package:flutter_collegeapp/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numberpicker/numberpicker.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({Key? key}) : super(key: key);

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  String _currentDayValue = "Monday";
  int _currentCreditsValue = 0;
  int _currentStartHour = 8;
  int _currentStartMinute = 15;
  int _currentEndHour = 10;
  int _currentEndMinute = 0;
  var _courseNameTextController = TextEditingController();
  var _courseCodeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var selectedCourse;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _courseCodeTextController.dispose();
    _courseNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedCourse = AppLocalizations.of(context)?.select_from_list ?? 'Select from list...';
    });
    return Scaffold(
        appBar: header(context, isMenu: false),
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
                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()){
                              _saveCourse(context);
                            }
                          },
                          icon: Icon(Icons.check, color: Color(0xFFA5D6A7), size: 45),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () => _showSelectCourseDialog(),
                        child: Text(
                          AppLocalizations.of(context)?.select_from_list ?? 'Select from list...',
                          style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                      child: TextFormField(
                        controller: _courseNameTextController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)?.course_name ?? 'Course name',
                          hintStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 18, color: Color(0xFF4F4F4F)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC7E5C8)
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC7E5C8)
                              )
                          ),
                        ),
                        cursorColor: Color(0xFFC7E5C8),
                        style: TextStyle(fontFamily: 'Glory', fontSize: 18, color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      child: TextFormField(
                        controller: _courseCodeTextController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)?.course_code ?? 'Course code',
                          hintStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 18, color: Color(0xFF4F4F4F)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC7E5C8)
                              )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC7E5C8)
                              )
                          ),
                        ),
                        cursorColor: Color(0xFFC7E5C8),
                        style: TextStyle(fontFamily: 'Glory', fontSize: 18, color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
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
                          onChanged: (value) => setState(() {
                            _currentDayValue = Days.instance.days[value];
                          }),
                          textMapper: (numberText) {
                            switch(numberText){
                              case "0": return Days.instance.days[0];
                              case "1": return Days.instance.days[1];
                              case "2": return Days.instance.days[2];
                              case "3": return Days.instance.days[3];
                              case "4": return Days.instance.days[4];
                              default: return "";
                            }
                          },
                          value: Days.instance.days.indexOf(_currentDayValue),
                          selectedTextStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                          textStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 14, color: Color(0xFF4F4F4F)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.start ?? 'Start:',
                            style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                          ),
                          NumberPicker(
                            itemHeight: 40,
                            itemWidth: 50.0,
                            minValue: 8,
                            maxValue: 20,
                            onChanged: (value) => setState(() {
                              _currentStartHour = value;
                            }),
                            value: _currentStartHour,
                            selectedTextStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                            textStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 14, color: Color(0xFF4F4F4F)),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                          ),
                          NumberPicker(
                            itemHeight: 40,
                            itemWidth: 50.0,
                            minValue: 0,
                            maxValue: 59,
                            onChanged: (value) => setState(() {
                              _currentStartMinute = value;
                            }),
                            value: _currentStartMinute,
                            textMapper: (numberText) {
                              switch(numberText){
                                case "0": return "00";
                                case "1": return "01";
                                case "2": return "02";
                                case "3": return "03";
                                case "4": return "04";
                                case "5": return "05";
                                case "6": return "06";
                                case "7": return "07";
                                case "8": return "08";
                                case "9": return "09";
                                default: return numberText;
                              }
                            },
                            selectedTextStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                            textStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 14, color: Color(0xFF4F4F4F)),
                          ),
                          Text(
                            AppLocalizations.of(context)?.end ?? 'End:',
                            style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                          ),
                          NumberPicker(
                            itemHeight: 40,
                            itemWidth: 50.0,
                            minValue: 8,
                            maxValue: 20,
                            onChanged: (value) => setState(() {
                              _currentEndHour = value;
                            }),
                            value: _currentEndHour,
                            selectedTextStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                            textStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 14, color: Color(0xFF4F4F4F)),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                          ),
                          NumberPicker(
                            itemHeight: 40,
                            itemWidth: 50.0,
                            minValue: 0,
                            maxValue: 59,
                            onChanged: (value) => setState(() {
                              _currentEndMinute = value;
                            }),
                            value: _currentEndMinute,
                            textMapper: (numberText) {
                              switch(numberText){
                                case "0": return "00";
                                case "1": return "01";
                                case "2": return "02";
                                case "3": return "03";
                                case "4": return "04";
                                case "5": return "05";
                                case "6": return "06";
                                case "7": return "07";
                                case "8": return "08";
                                case "9": return "09";
                                default: return numberText;
                              }
                            },
                            selectedTextStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                            textStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 14, color: Color(0xFF4F4F4F)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.credits ?? 'Credits:',
                            style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () => setState(() {
                              _currentCreditsValue--;
                            }),
                            child: Text(
                              "-",
                              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                            ),
                          ),
                          Text(
                            _currentCreditsValue.toString(),
                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () => setState(() {
                              _currentCreditsValue++;
                            }),
                            child: Text(
                              "+",
                              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
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

  void _saveCourse(BuildContext context){
    var course = CourseData(courseCode: _courseCodeTextController.text,
          name: _courseNameTextController.text,
          credits: _currentCreditsValue,
          time: "$_currentDayValue $_currentStartHour:$_currentStartMinute-$_currentEndHour:$_currentEndMinute");
    BlocProvider.of<CoursesCubit>(context).createCourse(course);
    _courseNameTextController.text = '';
    _courseCodeTextController.text = '';
    _currentCreditsValue = 0;
    _currentStartHour = 8;
    _currentStartMinute = 15;
    _currentEndHour = 10;
    _currentEndMinute = 0;
  }

  Future<void> _showSelectCourseDialog() async {
    BlocProvider.of<CoursesCubit>(context)..getLocalCourses();
    var _selectedCourse = await showDialog<CourseData>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state){
                if(state is ListCoursesSuccess){
                  //print(state.courses);
                  return SimpleDialog(
                    children: state.courses.map((course) =>
                          SimpleDialogOption(
                              child: Text(
                                course.name,
                                style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                              ),
                            onPressed: () => Navigator.pop(context, course),
                          )
                      ).toList(),
                  );
                } else if(state is ListCoursesFailure){
                  return Center(child: Text(state.exception.toString()));
                } else {
                  return LoadingView();
                }
              },
          );
      },
    );

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
      });
    }

  }
}
