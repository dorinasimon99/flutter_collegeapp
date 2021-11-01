import 'package:flutter_collegeapp/models/ModelProvider.dart';


class UsersRepository {

  Future<List<UserData>> getUsers() async {
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
        UserData(name: "Test Student", username: "teststudent", role: "STUDENT"),
        UserData(name: "Test Teacher", username: "testteacher", role: "TEACHER"),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<UserData> getUserByUsername(String username) async {
    try{
      return UserData(name: "Test Student", username: username, role: "STUDENT");
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUser(UserData user) async {
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        
      }''';

      print("User created");
      //Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(UserData user) async {
    //final updatedCard = card.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}