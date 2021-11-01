import 'package:flutter_collegeapp/models/ModelProvider.dart';


class TodosRepository {

  Future<List<TodoData>> getTodos(String courseID) async {
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
        TodoData(name: "Todo1", done: true, owner: "", courseCode: courseID, deadline: "2021.12.10."),
        TodoData(name: "Todo2", done: false, owner: "", courseCode: courseID),
        TodoData(name: "Todo3", done: true, owner: "", courseCode: courseID),
        TodoData(name: "Todo4", done: true, owner: "", courseCode: courseID),
        TodoData(name: "Todo5", done: false, owner: "", courseCode: courseID),
        TodoData(name: "Todo6", done: false, owner: "", courseCode: courseID),
        TodoData(name: "Todo7", done: false, owner: "", courseCode: courseID),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<TodoData>> getTodosWithDeadline() async {
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
        TodoData(name: "Todo1", done: true, owner: "", courseCode: "", deadline: "2021.12.10."),
        TodoData(name: "Todo2", done: false, owner: "", courseCode: "", deadline: "2021.11.10."),
        TodoData(name: "Todo3", done: false, owner: "", courseCode: "", deadline: "2021.11.13."),
        TodoData(name: "Todo4", done: true, owner: "", courseCode: "", deadline: "2021.11.28."),
        TodoData(name: "Todo5", done: true, owner: "", courseCode: "", deadline: "2021.12.01."),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createTodo(TodoData todo) async {

  }
}