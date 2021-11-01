//lesson neve
//dátum
//leírás
//kvíz: refresh gomb, akkor kéri le apitól

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/lesson/quiz_bloc/quiz_cubit.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app.dart';

class LessonPage extends StatefulWidget {

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {

  @override
  Widget build(BuildContext context) {
    LessonData lesson = ModalRoute.of(context)!.settings.arguments as LessonData;
    BlocProvider.of<QuizzesCubit>(context)..getQuizzes(lesson.id);
    return Scaffold(
      appBar: header(context, isMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lesson.title,
                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                ),
                Text(
                  lesson.date,
                  style: TextStyle(fontFamily: 'Glory', fontSize: 24, color: Colors.black),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                AppLocalizations.of(context)?.description ?? 'Description:',
                style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
              ),
            ),
            Text(
              lesson.description ?? "",
              style: TextStyle(fontFamily: 'Glory', fontSize: 24, color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)?.quizzes ?? 'Quizzes:',
                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                ),
                IconButton(
                  onPressed: () => BlocProvider.of<QuizzesCubit>(context)..getQuizzes(lesson.id),//Navigator.popAndPushNamed(context, 'lesson', arguments: lesson),
                  icon: Icon(Icons.refresh, color: Color(0xFFC7E5C8), size: 30),
                )
              ],
            ),
            Flexible(
              child: BlocBuilder<QuizzesCubit, QuizzesState>(
                  builder: (context, state) {
                    if (state is ListQuizzesSuccess) {
                      return ListView(
                        shrinkWrap: true,
                        children: state.quizzes.map((quiz) => QuizItem(quiz: quiz)).toList(),
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
    );}
}

class QuizItem extends StatelessWidget {
  final QuizData quiz;
  QuizItem({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFFC7E5C8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                      quiz.title,
                      style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                    ),
                ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_forward, color: Colors.black, size: 24),
              )
            ],
          ),
        )
    );
  }
}

