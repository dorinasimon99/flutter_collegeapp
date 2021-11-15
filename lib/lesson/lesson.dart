import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/bloc/quizzes/quiz_cubit.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app.dart';

class LessonPage extends StatefulWidget {

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  LessonData? lesson;
  String? _role;
  String? _name;
  bool _refresh = false;

  @override
  void initState(){
    _getUser();
    super.initState();
  }

  void _getUser() async {
    var role = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    var localName = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    if(role != null){
      setState(() {
        _role = role;
        _name = localName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_refresh){
      lesson = ModalRoute.of(context)!.settings.arguments as LessonData;
      BlocProvider.of<QuizzesCubit>(context)..getQuizzes(lesson!.id, _role);
    }
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocListener<LessonsCubit, LessonsState>(
          listener: (context, state) {
            if(state is CreateLessonSuccess){
              setState(() {
                _refresh = true;
                lesson = state.lesson;
              });
            } else if(state is CreateLessonFailure){
              showErrorAlert(state.exception.toString(), context);
            } else if(state is UpdateLessonSuccess){
              setState(() {
                _refresh = true;
                lesson = state.lesson;
              });
            } else if(state is UpdateLessonFailure){
              showErrorAlert(state.exception.toString(), context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        lesson!.title,
                        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                      ),
                    ),
                    _role == Roles.instance.teacher ? IconButton(
                      onPressed: _navigateToAddLesson,
                      icon: Icon(Icons.edit, size: 40, color: Colors.black),
                    ) : Container()
                  ],
                ),
                Text(
                  lesson!.date,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${AppLocalizations.of(context)?.description ?? 'Description'}:',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                  ),
                ),
                Text(
                  lesson!.description ?? "",
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)?.quizzes ?? 'Quizzes:',
                        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<QuizzesCubit>(context)..getQuizzes(lesson!.id, _role);
                      },
                      icon: Icon(Icons.refresh, color: Color(0xFFBED7BF), size: 30),
                    ),
                    _role == Roles.instance.teacher ? TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'addQuiz', arguments: lesson!.id),
                      child: Text(
                        '+',
                        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                      ),
                    ) : Container()
                  ],
                ),
                BlocListener<QuizzesCubit, QuizzesState>(
                  listener: (context, state){
                    if(state is CreateQuizSuccess){
                      BlocProvider.of<QuizzesCubit>(context)..getQuizzes(lesson!.id, _role);
                    } else if(state is CreateQuizFailure){
                      showErrorAlert(state.exception.toString(), context);
                    }
                  },
                  child: Container(),
                ),
                Flexible(
                  child: BlocBuilder<QuizzesCubit, QuizzesState>(
                    builder: (context, state) {
                      if (state is ListQuizzesSuccess) {
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: state.quizzes.map((quiz) => QuizItem(quiz: quiz, role: _role)).toList(),
                        );
                      } else if (state is ListQuizzesFailure) {
                        return Center(child: Text(state.exception.toString()));
                      } else {
                        return LoadingView();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );}

    void _navigateToAddLesson() async {
      Navigator.pushNamed(context, 'addLesson', arguments: [UserCourse(name: _name!,
          username: lesson!.owner, courseCode: lesson!.courseCode), lesson]);
    }
}

class QuizItem extends StatefulWidget {
  final QuizData quiz;
  final String? role;

  QuizItem({required this.quiz, this.role});

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  bool _isVisible = false;

  @override
  void initState(){
    super.initState();
    setState(() {
      _isVisible = widget.quiz.visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    child: Text(
                          widget.quiz.title,
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                        ),
                    ),
                  widget.role != null && widget.role == Roles.instance.teacher ? IconButton(
                    onPressed: () => Navigator.pushNamed(context, 'addQuiz', arguments: [widget.quiz.lessonID, widget.quiz]),
                    icon: Icon(Icons.edit, color: Colors.black, size: 24),
                  ): IconButton(
                    onPressed: () => _openQuiz(widget.quiz.link),
                    icon: Icon(Icons.arrow_forward, color: Colors.black, size: 24),
                  )
                ],
              ),
              widget.role != null && widget.role == Roles.instance.teacher ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)?.visible ?? 'Visible'}:',
                    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  ),
                  Switch(
                    value: _isVisible,
                    onChanged: (visible) {
                      setState(() {
                        _isVisible = visible;
                      });
                      QuizData quiz = widget.quiz.copyWith(visible: _isVisible);
                      BlocProvider.of<QuizzesCubit>(context)..updateQuiz(quiz);
                      },
                    activeTrackColor: Color(0xFF98AC99),
                    activeColor: Colors.white,
                  ),
                ],
              ) : widget.quiz.description != null && widget.quiz.description!.isNotEmpty ? Row(
                children: [
                  IconButton(
                    onPressed: () => _getClipBoard(widget.quiz.description!, context),
                    icon: Icon(Icons.copy, size: 24, color: Colors.black),
                  ),
                  Text(
                    widget.quiz.description ?? '',
                    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  ),
                ],
              ) : Container()
            ],
          ),
        )
    );
  }

  void _openQuiz(String _url) async {
    await launch(_url);
  }

  void _getClipBoard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    var snackBar = SnackBar(
      content: Text(AppLocalizations.of(context)?.copied ?? 'Copied', style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20)),
      backgroundColor: Color(0xFFBED7BF)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

