import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/bloc/teachers/teachers_cubit.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_collegeapp/students/students.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app.dart';

class CourseDetailsPage extends StatefulWidget {
  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  late CourseData course;
  String? localName;
  String? localUserRole;
  String? localUsername;
  int? localSemester;

  void _getLocalUser() async {
    var name = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    var role = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    var semester = await LocalStorage.localStorage.readInt(LocalStorage.SIGNED_IN_SEMESTER);
    if(role != null && name != null && semester != null){
      setState(() {
        localUserRole = role;
        localName = name;
        localSemester = semester;
      });

    }
  }

  @override
  void initState(){
    super.initState();
    _getLocalUser();
  }

  @override
  Widget build(BuildContext context){
    List<Object?> args = ModalRoute.of(context)!.settings.arguments as List<Object?>;
    course = args[0] as CourseData;
    localUsername = args[1] as String?;
    if(localUserRole != null){
      if(localUserRole == Roles.instance.student){
        BlocProvider.of<TeachersCubit>(context)..getCourseTeachers(course.courseCode);
      }
    } else {
      debugPrint("Role is null!");
    }
    return Scaffold(
        appBar: Header(context, isMenu: false),
        bottomNavigationBar: HomeButton(context),
        body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocListener<TodosCubit, TodosState>(
                      listener: (context, state){
                        if(state is CreateTodoSuccess){
                          if(localUserRole != null){
                            BlocProvider.of<TodosCubit>(context)..getTodos(localUsername, course.courseCode);
                          }
                        } else if(state is UpdateTodoSuccess){
                          if(localUserRole != null){
                            BlocProvider.of<TodosCubit>(context)..getTodos(localUsername, course.courseCode);
                          }
                        } else if (state is ListLessonTodosSuccess){
                          BlocProvider.of<TodosCubit>(context)..getTodos(localUsername, course.courseCode);
                        } else if(state is CreateTodoFailure){
                          showErrorAlert(state.exception.toString(), context);
                        } else if(state is UpdateTodoFailure){
                          showErrorAlert(state.exception.toString(), context);
                        } else if (state is ListLessonTodosFailure){
                          showErrorAlert(state.exception.toString(), context);
                        }
                      },
                      child: Container(),
                    ),
                    BlocListener<TeachersCubit, TeachersState>(
                      listener: (context, state){
                        if(state is ListTeachersSuccess){
                          BlocProvider.of<TodosCubit>(context)..getTodos(localUsername, course.courseCode);
                        } else if(state is ListTeachersFailure){
                          showErrorAlert(state.exception.toString(), context);
                        }
                      },
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              course.name,
                              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 35),
                            ),
                          ),
                          BlocListener<CoursesCubit, CoursesState>(
                            listener: (context, state) {
                              if(state is DeleteCourseSuccess){
                                Navigator.pop(context);
                              } else if (state is UpdateCourseSuccess){
                                Navigator.pop(context);
                              } else if(state is DeleteCourseFailure){
                                showErrorAlert(state.exception.toString(), context);
                              } else if(state is UpdateCourseFailure){
                                showErrorAlert(state.exception.toString(), context);
                              }
                            },
                            child: IconButton(
                              onPressed: () => _showDeleteCourseDialog(),
                              icon: Icon(Icons.delete, color: Colors.black, size: 40),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Text(
                              '${AppLocalizations.of(context)?.lessons ?? 'Lessons'}...',
                              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                            ),
                            onTap: () => Navigator.pushNamed(context, "lessons", arguments: course),
                          ),

                        ],
                      ),
                    ),
                    localUserRole != null && localUserRole == Roles.instance.student ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.teachers ?? 'Teachers',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                        ),
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          child: Text(
                            '${AppLocalizations.of(context)?.students ?? 'Students'}...',
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                          ),
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentsPage(course: course))),
                        ),

                      ],
                    ),
                    localUserRole != null && localUserRole == Roles.instance.student ? Container(
                      height: 150,
                      child: TeachersList(courseCode: course.courseCode),
                    ) : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.todos ?? 'Todos' ,
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, 'addTodo', arguments: course),
                          child: Text(
                            "+",
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    ),
                    BlocBuilder<TodosCubit, TodosState>(
                      builder: (context, state) {
                        if(state is ListTodosSuccess){
                          return TodosList(todos: state.todos);
                        } else if(state is ListTodosFailure){
                          return Center(child: Text(state.exception.toString()));
                        } else return LoadingView();
                      },
                    ),
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
      builder: (context) {
        return DeleteCourseDialog(localName: localName, localUsername: localUsername, localSemester: localSemester, course: course);
      },
    );
  }
}

class DeleteCourseDialog extends StatefulWidget {
  final String? localName;
  final String? localUsername;
  final int? localSemester;
  final CourseData? course;
  DeleteCourseDialog({this.localName, this.localUsername, this.localSemester, this.course});

  @override
  _DeleteCourseDialogState createState() => _DeleteCourseDialogState();
}

class _DeleteCourseDialogState extends State<DeleteCourseDialog> {
  int? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)?.delete_course ?? "Delete course",
        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)?.grade ?? "Grade:",
            style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
          ),
          DropdownButton<int>(
            value: _dropDownValue ?? 1,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)?.just_delete.toUpperCase() ?? "JUST DELETE",
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if(widget.localName != null){
                      BlocProvider.of<CoursesCubit>(context)..deleteCourse(widget.localName!, widget.course!);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)?.delete_and_save.toUpperCase() ?? "DELETE AND SAVE GRADE",
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if(widget.localName != null){
                      BlocProvider.of<CoursesCubit>(context)..updateCourse(widget.localUsername!, widget.localSemester!, widget.localName!, widget.course!.courseCode,
                          widget.course!, visible: false,
                          grade: _dropDownValue);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)?.cancel.toUpperCase() ?? "CANCEL",
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


class TeachersList extends StatelessWidget {
  final String? courseCode;
  TeachersList({this.courseCode});

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
                style: Resources.customTextStyles.getCustomTextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TodosList extends StatefulWidget {
  final List<TodoData> todos;

  TodosList({required this.todos});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: widget.todos.map((todo) => TodoItem(todo: todo)).toList(),
    );
  }
}


class TodoItem extends StatefulWidget {
  final TodoData? todo;
  TodoItem({required this.todo});

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool done = false;

  @override
  void initState(){
    if(widget.todo != null){
      done = widget.todo!.done;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.todo != null ? Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
      child: Card(
        color: Resources.customColors.todoBackGround,
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
                      widget.todo!.name,
                      style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                    ),
                    widget.todo!.deadline != null ? Text(
                      "${AppLocalizations.of(context)?.deadline ?? "Deadline:"} ${widget.todo!.deadline}",
                      style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                    ) : Container()
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    done = !done;
                  });
                  TodoData updated = widget.todo!.copyWith(done: true);
                  BlocProvider.of<TodosCubit>(context)..updateTodo(updated);
                },
                icon: done ? Image.asset('assets/checkbox_on.png') : Image.asset('assets/checkbox_off.png'),
              ),
            ],
          ),
        ),
      ),
    ) : Container();
  }
}