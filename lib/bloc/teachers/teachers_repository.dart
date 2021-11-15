import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/teacher/teacher_model.dart';


class TeachersRepository {

  Future<List<TeacherModel>> getCourseTeachers(String courseCode) async {
    try {
      var item = (await Amplify.DataStore.query(CourseData.classType,
          where: CourseData.COURSECODE.eq(courseCode)))[0];
      var teachers = <TeacherModel>[];
      if(item.teachers != null){
        for(var teacher in item.teachers!){
          teachers.add(TeacherModel(name: teacher));
        }
      }

      return teachers;
    } catch (e) {
      throw e;
    }
  }
}