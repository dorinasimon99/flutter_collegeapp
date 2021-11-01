import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/courses/teachers/teachers_cubit.dart';
import 'package:flutter_collegeapp/courses/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../app.dart';

class CourseDetailsPage extends StatefulWidget {
  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  late CourseData course;

  int _dropDownValue = 1;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context)!.settings.arguments as CourseData;
    BlocProvider.of<TeachersCubit>(context)..getCourseTeachers(course.id);
    BlocProvider.of<TodosCubit>(context)..getTodos(course.id);
    return Scaffold(
      appBar: header(context, isMenu: false),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              child: homeButton(context))
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.name,
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () => _showDeleteCourseDialog(),
                        icon: Icon(Icons.delete, color: Colors.black, size: 40),
                      )
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.teachers ?? 'Teachers',
                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                ),
                Container(
                  height: 150,
                  child: TeachersList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.todos ?? 'Todos',
                      style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'addTodo', arguments: course),
                      child: Text(
                        "+",
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                      ),
                    )
                  ],
                ),
                TodosList(),
              ],
            ),
          ),
        ],
          ),
      );
  }

  Future<void> _showDeleteCourseDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)?.delete_course ?? "Delete course",
            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 AppLocalizations.of(context)?.grade ?? "Grade:",
                 style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
               ),
               DropdownButton<int>(
                 value: _dropDownValue,
                 items: [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                   return DropdownMenuItem<int>(
                     value: value, child: Text(
                        value.toString(),
                        style: TextStyle(fontSize: 20),
                   ));
                 }).toList(),
                 onChanged: (int? newValue){
                   setState(() {
                     _dropDownValue = newValue!;
                   });
                 },
               )
            ],
          ),
          actions: <Widget>[
            Column(
              children: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)?.just_delete.toUpperCase() ?? "JUST DELETE",
                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    //TODO delete
                    Navigator.of(context).pop();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)?.cancel.toUpperCase() ?? "CANCEL",
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)?.delete_and_save.toUpperCase() ?? "DELETE AND SAVE RESULT",
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                      ),
                      onPressed: () {
                        //TODO save and delete
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class TeachersList extends StatelessWidget {
  const TeachersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeachersCubit, TeachersState>(
      builder: (context, state) {
        if (state is ListTeachersSuccess) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: state.teachers.map((teacher) => TeacherItem(teacherName: teacher.name,
                teacherImage: teacher.image)).toList(),
          );
        } else if (state is ListTeachersFailure) {
          return Center(child: Text(state.exception.toString()));
        } else {
          return LoadingView();
        }
      },
    );
  }
}


class TeacherItem extends StatelessWidget {
  final String? teacherImage;
  final String teacherName;
  TeacherItem({required this.teacherName, this.teacherImage});

  @override
  Widget build(BuildContext context) {
    var backgroundImage;
    if(teacherImage != null){
      backgroundImage = NetworkImage(teacherImage!);
    } else {
      backgroundImage = AssetImage("assets/avatar.png");
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, 'teacherRatings', arguments: teacherName),
        child: Container(
          width: 100,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: backgroundImage,
                radius: 40,
              ),
              Text(
                teacherName,
                style: TextStyle(fontFamily: 'Glory', fontSize: 18, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TodosList extends StatelessWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is ListTodosSuccess) {
          return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: state.todos
                .map((todo) => TodoItem(todo: todo))
                .toList(),
          );
        } else if (state is ListTodosFailure) {
          return Center(child: Text(state.exception.toString()));
        } else {
          return LoadingView();
        }
      },
    );
  }
}


class TodoItem extends StatefulWidget {
  final TodoData todo;
  TodoItem({required this.todo});

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool done = false;

  @override
  void initState(){
    done = widget.todo.done;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFD7FFD9),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.name,
                    style: TextStyle(fontFamily: 'Glory', fontSize: 24, color: Colors.black),
                  ),
                  widget.todo.deadline != null ? Text(
                    "${AppLocalizations.of(context)?.deadline ?? "Deadline:"} ${widget.todo.deadline}",
                    style: done ? TextStyle(fontFamily: 'Glory', fontSize: 24, color: Colors.black, decoration: TextDecoration.lineThrough) :
                    TextStyle(fontFamily: 'Glory', fontSize: 24, color: Colors.black),
                  ) : Container()
                ],
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                done = !done;
              }),
              icon: done ? Image.asset('assets/checkbox_on.png') : Image.asset('assets/checkbox_off.png'),
            )
          ],
        ),
      ),
    );
  }
}


