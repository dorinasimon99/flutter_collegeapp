import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/app.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/TodoData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  @override
  void dispose(){
    _todoNameController.dispose();
    super.dispose();
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
            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)?.lesson ?? 'Lesson'}:',
                  style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                ),
                BlocProvider(
                  create: (context) => LessonsCubit()..getCourseLessons(course.courseCode),
                  child: BlocBuilder<LessonsCubit, LessonsState>(
                    builder: (context, state) {
                      if(state is ListCourseLessonsSuccess){
                        return DropdownButton<LessonData>(
                            value: _selectedLesson,
                            items: state.lessons.map<DropdownMenuItem<LessonData>>((LessonData value){
                              return DropdownMenuItem<LessonData>(
                                  value: value,
                                  child: Text(
                                    value.title.toString(),
                                    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                                  )
                              );
                            }).toList(),
                          onChanged: (LessonData? newValue){
                            setState(() {
                              _selectedLesson = newValue;
                            });
                          },
                        );
                      } else if(state is ListCourseLessonsFailure){
                        return Center(child: Text(state.exception.toString()));
                      } else return LoadingView();
                    },
                  ),
                ),
              ],
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
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+5),
    );
    if(picked != null && picked != DateTime.now()){
      setState(() {
        _selectedDate = DateFormat('yyyy.MM.dd.').format(picked);
      });
    }
  }

}
