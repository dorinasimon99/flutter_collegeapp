import 'package:flutter_collegeapp/models/CourseData.dart';

class ListCoursesData {
  CourseList list;

  ListCoursesData(this.list);

  factory ListCoursesData.fromJson(dynamic json){
    var objJson = json['listCourseDatas'];
    return ListCoursesData(CourseList.fromJson(objJson));
  }
}

class CourseList {
  List<CourseData> items;

  CourseList(this.items);

  factory CourseList.fromJson(dynamic json){
    List<CourseData> _courses = [];
    if(json != []){
      var coursesObjJson = json['items'] as List;
      _courses = coursesObjJson.map((coursesJson) => CourseData.fromJson(coursesJson)).toList();
    }

    return CourseList(
        _courses
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class CreateCourseData {
  CourseData course;

  CreateCourseData(this.course);

  factory CreateCourseData.fromJson(dynamic json){
    var objJson = json['createCourseData'];
    return CreateCourseData(CourseData.fromJson(objJson));
  }
}