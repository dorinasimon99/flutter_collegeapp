import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayLessonsList extends StatelessWidget {
  final List<LessonData> lessons;
  final String? localUser;
  TodayLessonsList({required this.lessons, required this.localUser});

  @override
  Widget build(BuildContext context) {
    return lessons.length >= 1
    ? ListView(
      shrinkWrap: true,
      children: lessons.map((lesson) => LessonItem(lesson: lesson, localUser: localUser)).toList(),
    )
    : Center(
      child: Text(
        AppLocalizations.of(context)?.no_todo_today ?? 'There is 0 todo for today.',
        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
      ),
    )
    ;
  }
}

class LessonItem extends StatefulWidget {
  LessonData? lesson;
  final String? localUser;

  LessonItem({this.lesson, this.localUser});

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  int _todoNum = 0;
  List<TodoData> _lessonTodos = [];

  @override
  void initState(){
    super.initState();
    BlocProvider.of<TodosCubit>(context)..getLessonTodos(widget.localUser, widget.lesson!.id);
  }

  @override
  Widget build(BuildContext context) {
    return widget.lesson != null ? TextButton(
      onPressed: () => Navigator.pushNamed(context, 'lesson', arguments: widget.lesson),
      child: Card(
        color: Resources.customColors.cardGreen,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.lesson!.title,
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                        ),
                        Text(
                          widget.lesson!.time,
                          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  BlocListener<TodosCubit, TodosState>(
                    listener: (context, state){
                      if(state is UpdateTodoSuccess){
                        BlocProvider.of<TodosCubit>(context)..getLessonTodos(widget.localUser, widget.lesson!.id);
                      } else if(state is CreateTodoSuccess){
                        BlocProvider.of<TodosCubit>(context)..getLessonTodos(widget.localUser, widget.lesson!.id);
                      }
                      else if(state is ListLessonTodosSuccess){
                        if(state.lessonID == widget.lesson!.id){
                          _todoNum = state.todos.length;
                          setState(() {
                            _lessonTodos = state.todos;
                          });
                        } else {
                          setState(() {
                            _lessonTodos = <TodoData>[];
                          });
                        }
                      } else if(state is UpdateTodoFailure){
                        showErrorAlert(state.exception.toString(), context);
                      } else if(state is CreateTodoFailure){
                        showErrorAlert(state.exception.toString(), context);
                      } else if(state is ListLessonTodosFailure){
                        showErrorAlert(state.exception.toString(), context);
                      }
                    },
                    child: Column(
                      children: [
                        Text(
                          _lessonTodos.isNotEmpty ?
                          '${_lessonTodos.length} ${AppLocalizations.of(context)?.todo ?? 'todo'}' :
                          '$_todoNum ${AppLocalizations.of(context)?.todo ?? 'todo'}',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    ) : Container();
  }
}

