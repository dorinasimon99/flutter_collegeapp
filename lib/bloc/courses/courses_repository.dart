import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_repository.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

class CoursesRepository {

  Future<List<CourseData>> getCourses() async {
    try {
      var items = await Amplify.DataStore.query(CourseData.classType);
      return items;

    } catch (e) {
      throw e;
    }
  }

  Future<List<CourseData>> getUserCourses(String username) async {
    try {
      var userCourses = await UserCoursesRepository().getUserCoursesByUsername(username);
      var allCourses = await Amplify.DataStore.query(CourseData.classType);
      var courseCodes = <String>[];
      for(var userCourse in userCourses){
        courseCodes.add(userCourse.courseCode);
      }
      var courses = allCourses.where((element) => courseCodes.contains(element.courseCode)).toList();

      return courses;

    } catch (e){
      throw e;
    }
  }

  Future<List<CourseData>> getActualSemesterCourses(String username, int? actualSemester) async {
    try {
      var userCourses = <UserCourse>[];
      if(actualSemester == null){
        userCourses = await UserCoursesRepository().getUserCoursesByUsername(username);
      } else {
        userCourses = await UserCoursesRepository().getActualSemesterUserCourses(username, actualSemester);
      }
      var allCourses = await Amplify.DataStore.query(CourseData.classType);
      var courseCodes = <String>[];
      for(var userCourse in userCourses){
        courseCodes.add(userCourse.courseCode);
      }
      var courses = allCourses.where((element) => courseCodes.contains(element.courseCode)).toList();
      return courses;

    } catch (e){
      throw e;
    }
  }

  Future<List<CourseData>> getTeacherCourses(String teacherName) async {
    try {
      var teacherCourses = await Amplify.DataStore.query(CourseData.classType,
          where: CourseData.TEACHERS.contains(teacherName));
      return teacherCourses;
    } catch (e){
      throw e;
    }
  }

  Future<void> createCourse(String username, String name, int semester, CourseData course) async {
    try {
      await Amplify.DataStore.save(course);
      await Amplify.DataStore.save(UserCourse(name: name, username: username, courseCode: course.courseCode, semester: semester));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCourse(String username, int semester, String name, String oldCourseCode, CourseData course, {bool? visible, int? grade}) async {
    try {
      await Amplify.DataStore.save(course);
      var userCourse = await UserCoursesRepository().getUserCourseByNameAndCourseCode(name, oldCourseCode);
      if(userCourse != null){
          if(grade != null){
            if(visible != null){
              await UserCoursesRepository().updateUserCourse(userCourse.copyWith(courseCode: course.courseCode, visible: visible, grade: grade));
            } else {
              await UserCoursesRepository().updateUserCourse(userCourse.copyWith(courseCode: course.courseCode, grade: grade));
            }
          } else {
            await UserCoursesRepository().updateUserCourse(userCourse.copyWith(courseCode: course.courseCode));
          }
      } else {
        await UserCoursesRepository().createUserCourse(UserCourse(name: name, username: username, courseCode: course.courseCode, semester: semester));
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteCourse(String name, CourseData course) async {
    try{
      await UserCoursesRepository().deleteUserCourse(name, course.courseCode);
    } catch(e){
      throw e;
    }
  }
}