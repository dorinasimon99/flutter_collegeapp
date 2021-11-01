import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class CommentsRepository {

  Future<List<CommentData>> getComments(String teacherName, String courseName) async {
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

      var items = <CommentData>[
        CommentData(comment: "Some comment", coursename: courseName, teachername: teacherName),
        CommentData(comment: "Some comment", coursename: courseName, teachername: teacherName, name: "Commenter Name"),
        CommentData(comment: "Some comment", coursename: courseName, teachername: teacherName, name: "Commenter Name"),
        CommentData(comment: "Some comment", coursename: courseName, teachername: teacherName, name: "Commenter Name"),
        CommentData(comment: "Some comment", coursename: courseName, teachername: teacherName),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }


  Future<void> createComment(CommentData comment) async {
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        
      }''';

      Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateComment(CommentData comment) async {
    //final updatedCard = card.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}