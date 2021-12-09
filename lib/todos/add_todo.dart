import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/TodoData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late CourseData course;
  var _todoNameController = TextEditingController();
  String _selectedDate = "";
  LessonData? _selectedLesson;
  String? _role;

  @override
  void initState(){
    super.initState();
    _getUserRole();
  }

  @override
  void dispose(){
    _todoNameController.dispose();
    super.dispose();
  }

  void _getUserRole() async {
    var role = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    if(role != null){
      setState(() {
        _role = role;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context)!.settings.arguments as CourseData;
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            AppLocalizations.of(context)?.add_todo ?? 'Add todo',
              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
            ),
            TextFormField(
              controller: _todoNameController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.todo_name ?? 'Todo name',
                hintStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Color(0xFF4F4F4F)),
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
              style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      _selectedDate,
                      style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => _selectDate(context),
                    color: Resources.customColors.cardGreen,
                    child: Text(
                      AppLocalizations.of(context)?.add_deadline.toUpperCase() ?? 'ADD DEADLINE',
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)?.lesson ?? 'Lesson'}:',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                  ),
                  /*Flexible(
                    child:*/ BlocProvider(
                      create: (context) => LessonsCubit()..getCourseLessons(course.courseCode),
                      child: BlocBuilder<LessonsCubit, LessonsState>(
                        builder: (context, state) {
                          if(state is ListCourseLessonsSuccess){
                            return Flexible(
                              child: DropdownButton<LessonData>(
                                  value: _selectedLesson,
                                  items: state.lessons.map<DropdownMenuItem<LessonData>>((LessonData value){
                                    return DropdownMenuItem<LessonData>(
                                        value: value,
                                        child: Text(
                                              value.title.toString(),
                                              style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                                            ),
                                    );
                                  }).toList(),
                                onChanged: (LessonData? newValue){
                                  setState(() {
                                    _selectedLesson = newValue;
                                  });
                                },
                              ),
                            );
                          } else if(state is ListCourseLessonsFailure){
                            return Center(child: Text(state.exception.toString()));
                          } else return LoadingView();
                        },
                      ),
                    //),
                  ),
                ],
              ),
            ),
            BlocListener<TodosCubit, TodosState>(
              listener: (context, state) {
                if(state is CreateTodoSuccess){
                  showSnackBar(context, AppLocalizations.of(context)?.todo_created ?? 'Todo created', onActionPressed: () => Navigator.pop(context));
                } else if(state is CreateTodoFailure){
                  showErrorAlert(state.exception.toString(), context);
                }
              },
              child: MaterialButton(
                  onPressed: () => _createTodo(),
                  color: Resources.customColors.cardGreen,
                  child: Text(
                    AppLocalizations.of(context)?.save.toUpperCase() ?? 'SAVE',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                  ),
                ),
              ),
              ],
            ),
      ),
      );
  }

  void _createTodo() async{
    var todo = TodoData(name: _todoNameController.text,
        done: false, owner: await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME) ?? "",
        courseCode: course.courseCode, deadline: _selectedDate.isNotEmpty ? _selectedDate : null,
        lessonID: _selectedLesson?.id);
    BlocProvider.of<TodosCubit>(context)..createTodo(todo);
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+5),
      theme: ThemeData(primaryColor: Resources.customColors.cardGreen, accentColor: Resources.customColors.cardGreen),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleDayButton: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
        textStyleYearButton: Resources.customTextStyles.getCustomTextStyle(fontSize: 30),
        textStyleDayHeader: Resources.customTextStyles.getCustomTextStyle(fontSize: 20, color: Colors.grey),
        textStyleCurrentDayOnCalendar: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
        textStyleDayOnCalendar: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
        textStyleDayOnCalendarSelected: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
        textStyleDayOnCalendarDisabled: Resources.customTextStyles.getCustomTextStyle(fontSize: 20, color: Colors.grey),
        textStyleMonthYearHeader: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 25),
        paddingMonthHeader: EdgeInsets.all(32),
        paddingActionBar: EdgeInsets.all(16),
        sizeArrow: 50,
        colorArrowNext: Colors.black,
        colorArrowPrevious: Colors.black,
        marginLeftArrowPrevious: 16,
        marginTopArrowPrevious: 16,
        marginTopArrowNext: 16,
        marginRightArrowNext: 32,
        textStyleButtonPositive: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Resources.customColors.datePickerButtonGreen),
        textStyleButtonNegative: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Resources.customColors.datePickerButtonGreen.withOpacity(0.5)),
        decorationDateSelected: BoxDecoration(color: Resources.customColors.cardGreen, shape: BoxShape.circle),
        backgroundPicker: Colors.white,
        backgroundActionBar: Colors.white,
        backgroundHeaderMonth: Colors.white,

      )
    );
    if(picked != null && picked != DateTime.now()){
      setState(() {
        _selectedDate = DateFormat('yyyy.MM.dd.').format(picked);
      });
    }
  }

}
