import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchCoursesPage extends StatefulWidget {
  const SearchCoursesPage({Key? key}) : super(key: key);

  @override
  _SearchCoursesPageState createState() => _SearchCoursesPageState();
}

class _SearchCoursesPageState extends State<SearchCoursesPage> {

  @override
  Widget build(BuildContext context) {
    var _allCourses = ModalRoute.of(context)?.settings.arguments as List<CourseData>;
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SearchCoursesWidget(allCourses: _allCourses)
      ),
    );
  }
}

class SearchCoursesWidget extends StatefulWidget {
  final List<CourseData> allCourses;
  SearchCoursesWidget({required this.allCourses});

  @override
  _SearchCoursesWidgetState createState() => _SearchCoursesWidgetState();
}

class _SearchCoursesWidgetState extends State<SearchCoursesWidget> {
  var _foundCourses = <CourseData>[];

  @override
  void initState(){
    super.initState();
    _foundCourses = widget.allCourses;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: (value) {
            List<CourseData> results = [];
            if (value.isEmpty) {
              results = widget.allCourses;
            } else {
              results = widget.allCourses.where((course) =>
              course.name.toLowerCase().contains(value.toLowerCase()) || course.courseCode.toLowerCase().contains(value.toLowerCase())).toList();
            }
            setState(() {
              _foundCourses = results;
            });
          },
          cursorColor: Resources.customColors.cursorGreen,
          cursorHeight: 24,
          keyboardType: TextInputType.text,
          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.search ?? "Search for name or course code!",
              hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Resources.customColors.cursorGreen)
              )
          ),
        ),
        _foundCourses.isNotEmpty ? Flexible(
          child: ListView(
            shrinkWrap: true,
            children: _foundCourses.map((course) => TextButton(
              onPressed: () => Navigator.pop(context, course),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      '${course.name} (${course.courseCode})',
                      style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ) :
        Text(
          AppLocalizations.of(context)?.no_results ?? "No results",
          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
        )
      ],
    );
  }
}