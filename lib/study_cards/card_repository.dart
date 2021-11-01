import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class CardsRepository {

  Future<List<CardData>> getCards() async {
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

      var items = <CardData>[
        CardData(courseCode: "", courseName: "Course1", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
        CardData(courseCode: "", courseName: "Course2", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
        CardData(courseCode: "", courseName: "Course3", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
        CardData(courseCode: "", courseName: "Course4", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
        CardData(courseCode: "", courseName: "Course5", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
        CardData(courseCode: "", courseName: "Course6", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
        CardData(courseCode: "", courseName: "Course7", questions: ["Question 1", "Question 2", "Question 3"], answers: ["Answer 1", "Answer 2", "Answer 3"]),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createCard(CardData card) async {
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        
      }''';

      Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCard(CardData card) async {
    final updatedCard = card.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}