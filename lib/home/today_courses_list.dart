import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';

class TodayCoursesList extends StatelessWidget {
  final List<CourseData> courses;
  TodayCoursesList({required this.courses});

  @override
  Widget build(BuildContext context) {
    return courses.length >= 1
    ? ListView(
      shrinkWrap: true,
      children: courses.map((course) => CourseItem(course: course)).toList(),
    )
    : Center(
      child: Text(
        'There is 0 todo for today.'
      ),
    )
    ;
  }
}

class CourseItem extends StatelessWidget {
  final CourseData course;
  CourseItem({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFC7E5C8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.name,
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                      ),
                      Text(
                        course.time.split(" ")[1],
                        style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "3 todo",
                      style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

