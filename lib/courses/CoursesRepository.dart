import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';

import 'ListCoursesData.dart';

class CoursesRepository {

  Future<List<CourseData>> getCourses() async {
    try {
      String graphQLDocument = '''query ListCourses {
        listCourseDatas {
          items {
            id
            name
            time
          }
        }
      }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      var list = ListCoursesData.fromJson(jsonDecode(response.data));
      var items = list.list.items;

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CourseData>> getTodayCoursesFromAPI(String day) async {
    try {
      String graphQLDocument = '''query ListCourses {
        listCourseDatas(filter: {time: {contains: "''' + day + '''"}}) {
          items {
            id
            name
            time
          }
        }
      }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      var list = ListCoursesData.fromJson(jsonDecode(response.data));
      var items = list.list.items;

      return items;

    } catch (e) {
      throw e;
    }
  }

  Future<void> createCourse(String name, String code, int credits, String time) async {
    final newCourse = CourseData(id: UUID.getUUID(), courseCode: code, name: name, credits: credits, time: time);
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCourse(CourseData course) async {
    final updatedTodo = course.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}