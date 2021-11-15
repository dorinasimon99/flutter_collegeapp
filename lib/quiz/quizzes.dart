import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/bloc/quizzes/quiz_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({Key? key}) : super(key: key);

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  List<QuizData> _quizzes = [];


  @override
  void initState(){
    BlocProvider.of<QuizzesCubit>(context)..getAllQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                bottom: 0,
                child: HomeButton(context))
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)?.quizzes ?? 'Quizzes',
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: BlocListener<QuizzesCubit, QuizzesState>(
                  listener: (context, state) {
                    if (state is ListAllQuizzesSuccess) {
                      setState(() {
                        _quizzes = state.quizzes;
                      });
                    } else if (state is ListAllQuizzesFailure){
                      showErrorAlert(state.exception.toString(), context);
                    } else if(state is UpdateQuizSuccess){
                      BlocProvider.of<QuizzesCubit>(context)..getAllQuizzes();
                    } else if(state is UpdateQuizFailure){
                      showErrorAlert(state.exception.toString(), context);
                    }
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: _quizzes.map((quiz) => AllQuizItem(quiz: quiz)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllQuizItem extends StatefulWidget {
  final QuizData quiz;
  AllQuizItem({required this.quiz});

  @override
  State<AllQuizItem> createState() => _AllQuizItemState();
}

class _AllQuizItemState extends State<AllQuizItem> {
  LessonData? _quizLesson;

  @override
  void initState(){
    super.initState();
    BlocProvider.of<LessonsCubit>(context)..getLessonByID(widget.quiz.lessonID);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Resources.customColors.cardGreen,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              BlocListener<LessonsCubit, LessonsState>(
                listener: (context, state){
                  if(state is GetLessonSuccess && state.lesson.id == widget.quiz.lessonID){
                    setState(() {
                      _quizLesson = state.lesson;
                    });
                  } else if(state is GetLessonFailure){
                    showErrorAlert(state.exception.toString(), context);
                  }
                },
                child: Container(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.quiz.title,
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        _quizLesson?.title ?? "",
                        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, 'addQuiz', arguments: [widget.quiz.lessonID, widget.quiz]),
                  icon: Icon(Icons.edit, color: Colors.black, size: 24)
              )
            ],
          ),
        )
    );
  }
}