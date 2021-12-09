
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_repository.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class LessonsRepository {

  Future<LessonData> getLessonByID(String id) async {
    try {
      var item = (await Amplify.DataStore.query(LessonData.classType, where: LessonData.ID.eq(id)))[0];
      return item;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LessonData>> getLessons() async {
    try {
      var items = await Amplify.DataStore.query(LessonData.classType);
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LessonData>> getUserLessons(String username, int? actualSemester) async {
    try {
      var allLessons = await Amplify.DataStore.query(LessonData.classType);
      var userCourses = <UserCourse>[];
      if(actualSemester == null){
        userCourses = await UserCoursesRepository().getUserCoursesByUsername(username);
      } else {
        userCourses = await UserCoursesRepository().getActualSemesterUserCourses(username, actualSemester);
      }
      var items = <LessonData>[];
      for(var lesson in allLessons){
        if(userCourses.any((element) => element.courseCode == lesson.courseCode)){
          items.add(lesson);
        }
      }
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LessonData>> getCourseLessons(String courseCode) async {
    try {
      var items = await Amplify.DataStore.query(LessonData.classType, where: LessonData.COURSECODE.eq(courseCode));
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LessonData>> getTodayLessons(String username, int? actualSemester, String date) async {
    try {
      var lessons = await getUserLessons(username, actualSemester);
      var items = <LessonData>[];
      for(var lesson in lessons){
        if(lesson.date == date){
          items.add(lesson);
        }
      }
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createLesson(LessonData lesson) async {
    try {
      await Amplify.DataStore.save(lesson);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateLesson(LessonData lesson) async {
    try {
      await Amplify.DataStore.save(lesson);
    } catch (e) {
      throw e;
    }
  }
}