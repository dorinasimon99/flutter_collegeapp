import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class UserCoursesRepository {

  Future<List<UserCourse>> getUserCourses() async {
    try {
      var items = await Amplify.DataStore.query(UserCourse.classType,
          where: UserCourse.VISIBLE.eq(null).or(UserCourse.VISIBLE.eq(true).or(UserCourse.VISIBLE.eq('true'))));
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<UserCourse>> getActualSemesterUserCourses(String username, int actualSemester) async {
    try {
      var items = await Amplify.DataStore.query(UserCourse.classType,
      where: UserCourse.USERNAME.eq(username).and(UserCourse.SEMESTER.eq(actualSemester).
      and(UserCourse.VISIBLE.eq(null).or(UserCourse.VISIBLE.eq(true).or(UserCourse.VISIBLE.eq('true'))))
      ));

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<UserCourse?> getUserCourseByNameAndCourseCode(String name, String courseCode) async {
    try{
      var items = (await Amplify.DataStore.query(UserCourse.classType,
      where: UserCourse.NAME.eq(name).and(UserCourse.COURSECODE.eq(courseCode))
      .and(UserCourse.VISIBLE.eq(null).or(UserCourse.VISIBLE.eq(true).or(UserCourse.VISIBLE.eq('true'))))));
      return items.isNotEmpty ? items[0] : null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<UserCourse>> getUserCoursesByUsername(String username) async {
    try{
      var items = await Amplify.DataStore.query(UserCourse.classType,
          where: UserCourse.USERNAME.eq(username).and(UserCourse.VISIBLE.eq(null).or(UserCourse.VISIBLE.eq(true).or(UserCourse.VISIBLE.eq('true')))));

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUserCourse(UserCourse userCourse) async {
    try {
      await Amplify.DataStore.save(userCourse);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUserCourse(UserCourse userCourse) async {
    try {
      await Amplify.DataStore.save(userCourse);
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteUserCourse(String name, String courseCode) async {
    try{
      var item = (await Amplify.DataStore.query(UserCourse.classType,
          where: UserCourse.NAME.eq(name).and(UserCourse.COURSECODE.eq(courseCode))))[0];
      await Amplify.DataStore.delete(item);
    } catch(e){
      throw e;
    }
  }
}