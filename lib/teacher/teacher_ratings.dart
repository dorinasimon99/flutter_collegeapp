import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/bloc/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/CommentData.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/UserCourse.dart';
import 'package:flutter_collegeapp/bloc/comments/comment_cubit.dart';
import 'package:flutter_collegeapp/bloc/ratings/ratings_cubit.dart';
import 'package:flutter_collegeapp/teacher/rating_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class TeacherRatingPage extends StatefulWidget {
  const TeacherRatingPage({Key? key}) : super(key: key);

  @override
  _TeacherRatingPageState createState() => _TeacherRatingPageState();
}

class _TeacherRatingPageState extends State<TeacherRatingPage> {
  late String teacherName;
  String? _role;
  ImageProvider backgroundImage = AssetImage('assets/avatar.png');

  void _getUser() async {
    _role = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_ROLE);
    BlocProvider.of<UsersCubit>(context)..getUserByName(teacherName);
  }

  @override
  Widget build(BuildContext context) {
    teacherName = ModalRoute.of(context)!.settings.arguments as String;
    _getUser();
    return Scaffold(
      appBar: Header(context, isMenu: false),
      bottomNavigationBar: HomeButton(context),
      body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    teacherName,
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                  ),
                ),
                BlocListener<UsersCubit, UsersState>(
                  listener: (context, state) {
                    if(state is GetUserByNameSuccess){
                      if(state.user.name == teacherName && state.user.avatar != null){
                        if(state.user.avatar != null){
                          File image = File(state.user.avatar!);
                          if(image.existsSync()){
                            setState(() {
                              backgroundImage = FileImage(image);
                            });
                          }
                        } else {
                          setState(() {
                            backgroundImage = AssetImage('assets/avatar.png');
                          });
                        }
                      }
                      BlocProvider.of<CoursesCubit>(context)..getTeacherCourses(teacherName);
                    } else if(state is GetUserByNameFailure){
                      showErrorAlert(state.exception.toString(), context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: backgroundImage,
                        radius: 50,
                      ),
                    ],
                  ),
                ),
                Expanded(child: TeacherCoursesTabView(teacherName: teacherName, role: _role))
              ],
            ),
          ),
      );
  }


}

class TeacherCoursesTabView extends StatefulWidget {
  final String? teacherName;
  final String? role;
  TeacherCoursesTabView({this.teacherName, this.role});

  @override
  _TeacherCoursesTabViewState createState() => _TeacherCoursesTabViewState();
}

class _TeacherCoursesTabViewState extends State<TeacherCoursesTabView> {
  List<Tab> _tabs = <Tab>[];
  List<RatingsView> _tabContent = <RatingsView>[];
  var _courses = <CourseData>[];
  String? _selectedCourseCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)?.ratings ?? 'Ratings',
              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
            ),
            widget.role != null && widget.role == Roles.instance.student ? TextButton(
              onPressed: () {
                if(_selectedCourseCode != null){
                  Navigator.pushNamed(context, 'addRating', arguments: UserCourse(name: widget.teacherName!, username: "", courseCode: _selectedCourseCode!));
                }
              },
              child: Text(
                "+",
                style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
              ),
            ) : Container()
          ],
        ),
        Flexible(
          child: BlocListener<CoursesCubit, CoursesState>(
              listener: (context, state){
                if (state is ListTeachersCoursesSuccess){
                  setState(() {
                    _courses = state.courses;
                    _createTabs(state.courses);
                    _selectedCourseCode = state.courses[0].courseCode;
                  });
                } else if (state is ListTeachersCoursesFailure){
                  showErrorAlert(state.exception.toString(), context);
                }
              },
              child: _courses.isNotEmpty ? DefaultTabController(
                length: _courses.length,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            isScrollable: true,
                            indicatorColor: Resources.customColors.cursorGreen,
                            labelColor: Colors.black,
                            labelStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                            tabs: _tabs,
                            onTap: (index){
                              _selectedCourseCode = _courses[index].courseCode;
                            },
                          )
                        ],
                      ),
                      automaticallyImplyLeading: false,
                    ),
                    body: TabBarView(
                      children: _tabContent,
                    )
                ),
              ) : Container()
          ),
        ),
      ],
    );
  }

  void _createTabs(List<CourseData> courses){
    if(_tabs.isEmpty && _tabContent.isEmpty){
      for(var course in courses){
        _tabs.add(Tab(text: course.name));
        _tabContent.add(RatingsView(teacherName: widget.teacherName!, courseCode: course.courseCode, courseName: course.name));
      }
    }
  }
}


class RatingsView extends StatefulWidget {
  final String teacherName;
  final String courseCode;
  final String courseName;
  RatingsView({required this.teacherName, required this.courseCode, required this.courseName});

  @override
  _RatingsViewState createState() => _RatingsViewState();
}

class _RatingsViewState extends State<RatingsView> {
  RatingModel? rating;
  List<CommentData> _comments = [];

  @override
  void initState(){
    super.initState();
    BlocProvider.of<RatingsCubit>(context)..getRatings(widget.teacherName, widget.courseCode);
    BlocProvider.of<CommentsCubit>(context)..getComments(widget.teacherName, widget.courseCode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: BlocListener<RatingsCubit, RatingsState>(
                  listener: (context, state) {
                    if (state is GetRatingsSuccess) {
                      setState(() {
                        rating = state.rating;
                      });
                    } else if(state is UpdateRatingSuccess){
                      BlocProvider.of<RatingsCubit>(context)..getRatings(widget.teacherName, widget.courseCode);
                    } else if(state is GetRatingsFailure){
                      showErrorAlert(state.exception.toString(), context);
                    } else if(state is UpdateRatingFailure){
                      showErrorAlert(state.exception.toString(), context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${rating?.ratingNum ?? 0} ${AppLocalizations.of(context)?.rating ?? ''}",
                        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                      ),
                      RatingBar(
                        initialRating: double.parse(rating?.rating ?? '0.0'),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Color(0xFFA5D6A7),
                          ),
                          empty: Icon(Icons.star_border, color: Color(0xFFA5D6A7),
                          ),
                          half: Icon(Icons.star_half, color: Color(0xFFA5D6A7),
                          ),
                        ),
                        glow: false,
                        itemSize: 40,
                        onRatingUpdate: (rating) {},
                      )
                    ],
                  ),
                ),
            ),
            BlocListener<CommentsCubit, CommentsState>(
              listener: (context, state){
                if (state is ListCommentsSuccess){
                  setState(() {
                    _comments = state.comments;
                  });
                } else if (state is CreateCommentSuccess){
                  BlocProvider.of<CommentsCubit>(context)..getComments(widget.teacherName, widget.courseCode);
                } else if(state is ListCommentsFailure){
                  showErrorAlert(state.exception.toString(), context);
                } else if(state is CreateCommentFailure){
                  showErrorAlert(state.exception.toString(), context);
                }
              },
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _comments
                    .map((comment) => CommentItem(comment: comment))
                    .toList(),

              ),
            )
          ],
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentData comment;
  CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Resources.customColors.cardGreen,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                comment.name ?? "Anonymus",
                style: TextStyle(
                    fontFamily: 'Glory-Semi', fontSize: 18, color: Colors.black),
              ),
            ),
            Flexible(
              child: Text(
                comment.comment,
                style:
                    Resources.customTextStyles.getCustomTextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> getCurrentUserName() async {
    return await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
  }
}


