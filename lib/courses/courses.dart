import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app.dart';
import 'courses_cubit.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CoursesCubit>(context)..getLocalCourses();
    return Scaffold(
      appBar: header(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)?.my_courses ?? 'My courses',
                      style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'addCourse'),
                    child: Text(
                      "+",
                      style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                    ),
                  )
                ],
              ),
              Expanded(
                child: BlocBuilder<CoursesCubit, CoursesState>(
                    builder: (context, state) {
                      if (state is ListCoursesSuccess) {
                        return ListView(
                                shrinkWrap: true,
                                children: state.courses.map((course) => AllCourseItem(course: course)).toList(),
                            );
                      } else if (state is ListCoursesFailure) {
                        return Center(child: Text(state.exception.toString()));
                      } else {
                        return LoadingView();
                      }
                    },
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: homeButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AllCourseItem extends StatelessWidget {
  final CourseData course;
  AllCourseItem({required this.course});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'courseDetails', arguments: course),
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
                  Text(
                    course.name,
                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.time.split(" ")[1],
                    style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    course.courseCode,
                    style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    course.credits.toString(),
                    style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

