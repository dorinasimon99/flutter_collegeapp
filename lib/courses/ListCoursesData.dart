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
    var coursesObjJson = json['items'] as List;
    List<CourseData> _courses = coursesObjJson.map((coursesJson) => CourseData.fromJson(coursesJson)).toList();

    return CourseList(
        _courses
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}