import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

class TodayLessonsList extends StatelessWidget {
  final List<LessonData> lessons;
  TodayLessonsList({required this.lessons});

  @override
  Widget build(BuildContext context) {
    return lessons.length >= 1
    ? ListView(
      shrinkWrap: true,
      children: lessons.map((lesson) => LessonItem(lesson: lesson)).toList(),
    )
    : Center(
      child: Text(
        'There is 0 todo for today.'
      ),
    )
    ;
  }
}

class LessonItem extends StatelessWidget {
  final LessonData lesson;
  LessonItem({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'lesson', arguments: lesson),
      child: Card(
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
                          lesson.title,
                          style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                        ),
                        Text(
                          lesson.time,
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
      ),
    );
  }
}

