import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class QuizzesRepository {

  Future<List<QuizData>> getQuizzes(String lessonID) async {
    try {
      String graphQLDocument = '''query ListCourses {
        listCourseDatas {
          items {
            id
            name
            courseCode
            time
            credits
          }
        }
      }''';

      /*var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      var list = ListCoursesData.fromJson(jsonDecode(response.data));
      var items = list.list.items;*/

      var items = <QuizData>[
        QuizData(lessonID: lessonID, title: "Quiz1", questions: [], answers: []),
        QuizData(lessonID: lessonID, title: "Quiz2", questions: [], answers: []),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }


  Future<void> createQuiz(QuizData quiz) async {
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        
      }''';

      Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateQuiz(QuizData quiz) async {
    final updatedQuiz = quiz.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}