import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/local_database/database_models/database_course.dart';
import 'package:flutter_collegeapp/local_database/local_database.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';

class CoursesRepository {

  Future<List<CourseData>> getCourses() async {
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
        CourseData(courseCode: "BMEAU001", name: "Course1", credits: 4, time: "Monday 14:15-16:00"),
        CourseData(courseCode: "BMEAU002", name: "Course2", credits: 4, time: "Tuesday 8:15-10:00"),
        CourseData(courseCode: "BMEAU003", name: "Course3", credits: 4, time: "Wednesday 10:15-12:00"),
        CourseData(courseCode: "BMEAU004", name: "Course4", credits: 4, time: "Thursday 16:15-18:00"),
        CourseData(courseCode: "BMEAU005", name: "Course5", credits: 4, time: "Monday 8:15-10:00"),
        CourseData(courseCode: "BMEAU001", name: "Course6", credits: 4, time: "Monday 12:15-14:00"),
        CourseData(courseCode: "BMEAU002", name: "Course7", credits: 4, time: "Tuesday 16:15-18:00"),
        CourseData(courseCode: "BMEAU003", name: "Course8", credits: 4, time: "Wednesday 12:15-14:00"),
        CourseData(courseCode: "BMEAU004", name: "Course9", credits: 4, time: "Friday 16:15-18:00")
      ];

      var localCourses = await LocalDatabase.instance.readAllCourses();
      if(localCourses.isEmpty){
        for(var course in items){
          await LocalDatabase.instance.createCourse(course);
        }
      }

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CourseData>> getLocalCourses() async {
    var courses = await LocalDatabase.instance.readAllCourses();
    print(courses);
    return courses;
  }

  Future<List<CourseData>> getTeacherCourses(String teacherName) async {
    try{
      var items = [
        CourseData(courseCode: "", name: "Course1", credits: 4, time: ""),
        CourseData(courseCode: "", name: "Course2", credits: 4, time: ""),
        CourseData(courseCode: "", name: "Course3", credits: 4, time: ""),
        CourseData(courseCode: "", name: "Course4", credits: 4, time: ""),
        CourseData(courseCode: "", name: "Course5", credits: 4, time: ""),
      ];

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createCourse(CourseData course) async {
    //TODO courseCode alapján nézni az egyediséget
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        createCourseData(input: {name: "''' + course.name + '''", courseCode: "''' + course.courseCode + '''", credits: ''' + course.credits.toString() + ''', time: "''' + course.time + '''"}) {
          id
          name
          courseCode
          credits
          time
        }
      }''';

      Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCourse(CourseData course) async {
    final updatedCourse = course.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}