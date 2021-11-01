import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';


class LessonsRepository {

  Future<List<LessonData>> getLessons() async {
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
        LessonData(title: "Lesson1", date: "2021.10.27.", time: "14:15-16:00", courseCode: 'BMEAU001', ownerID: '', description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        LessonData(title: "Lesson2", date: "2021.10.28.", time: "8:15-10:00", courseCode: 'BMEAU005', ownerID: ''),
        LessonData(title: "Lesson3", date: "2021.10.29.", time: "10:15-12:00", courseCode: 'BMEAU002', ownerID: ''),
        LessonData(title: "Lesson4", date: "2021.11.02.", time: "10:15-12:00", courseCode: 'BMEAU002', ownerID: ''),
        LessonData(title: "Lesson5", date: "2021.11.03.", time: "16:15-18:00", courseCode: 'BMEAU005', ownerID: ''),
        LessonData(title: "Lesson6", date: "2021.11.04.", time: "14:15-16:00", courseCode: 'BMEAU003', ownerID: ''),
        LessonData(title: "Lesson7", date: "2021.11.05.", time: "10:15-12:00", courseCode: 'BMEAU004', ownerID: ''),
        LessonData(title: "Lesson8", date: "2021.11.05.", time: "14:15-16:00", courseCode: 'BMEAU005', ownerID: ''),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LessonData>> getTodayLessons(String date) async {
    try {
      String graphQLDocument = '''query ListCourses {
        listCourseDatas(filter: {time: {contains: "''' + date + '''"}}) {
          items {
            id
            name
            time
          }
        }
      }''';

      var courses = [
        LessonData(title: "Lesson1", date: "2021.10.27.", time: "14:15-16:00", courseCode: 'BMEAU002', ownerID: '', description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        LessonData(title: "Lesson2", date: "2021.10.28.", time: "8:15-10:00", courseCode: 'BMEAU001', ownerID: ''),
        LessonData(title: "Lesson3", date: "2021.10.29.", time: "10:15-12:00", courseCode: 'BMEAU002', ownerID: ''),
        LessonData(title: "Lesson4", date: "2021.11.02.", time: "10:15-12:00", courseCode: 'BMEAU005', ownerID: ''),
        LessonData(title: "Lesson5", date: "2021.11.03.", time: "16:15-18:00", courseCode: 'BMEAU003', ownerID: ''),
        LessonData(title: "Lesson6", date: "2021.11.04.", time: "14:15-16:00", courseCode: 'BMEAU004', ownerID: ''),
        LessonData(title: "Lesson7", date: "2021.11.05.", time: "10:15-12:00", courseCode: 'BMEAU004', ownerID: ''),
        LessonData(title: "Lesson8", date: "2021.11.05.", time: "14:15-16:00", courseCode: 'BMEAU005', ownerID: ''),
      ];

      /*var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      var list = ListCoursesData.fromJson(jsonDecode(response.data));
      var items = list.list.items;*/

      /*for (var item in items){
        CourseData course = CourseData(courseCode: item.courseCode, name: item.name, credits: item.credits, time: item.time);
        await Amplify.DataStore.save(course);
      }*/

      var items = <LessonData>[];

      for(var item in courses){
        if(item.date.contains(date)) items.add(item);
      }

      return items;

    } catch (e) {
      throw e;
    }
  }

  Future<void> createLesson(LessonData lesson) async {
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        
      }''';

      Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateLesson(LessonData lesson) async {
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}