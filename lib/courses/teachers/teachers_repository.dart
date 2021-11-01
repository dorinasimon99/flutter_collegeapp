import 'package:flutter_collegeapp/common/teacher_model.dart';


class TeachersRepository {

  Future<List<TeacherModel>> getCourseTeachers(String courseID) async {
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

      var items = [
        TeacherModel(name: "John Doe"),
        TeacherModel(name: "Teszt Elek"),
        TeacherModel(name: "Teacher Name"),
        TeacherModel(name: "Gipsz Jakab"),
        TeacherModel(name: "Jane Doe"),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }
}