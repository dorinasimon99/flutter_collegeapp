
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class QuizzesRepository {

  Future<List<QuizData>> getAllQuizzes() async {
    try {
      var items = await Amplify.DataStore.query(QuizData.classType);
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<QuizData>> getQuizzes(String lessonID, String? role) async {
    try {
      var items;
      if(role == Roles.instance.teacher){
        items = await Amplify.DataStore.query(QuizData.classType, where: QuizData.LESSONID.eq(lessonID));
      } else {
        items = await Amplify.DataStore.query(QuizData.classType, where: QuizData.LESSONID.eq(lessonID)
            .and(QuizData.VISIBLE.eq(true)));
      }
      return items;
    } catch (e) {
      throw e;
    }
  }


  Future<void> createQuiz(QuizData quiz) async {
    try {
      await Amplify.DataStore.save(quiz);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateQuiz(QuizData quiz) async {
    try {
      await Amplify.DataStore.save(quiz);
    } catch (e) {
      throw e;
    }
  }
}