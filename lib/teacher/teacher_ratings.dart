import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/models/CommentData.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/teacher/comment_bloc/comment_cubit.dart';
import 'package:flutter_collegeapp/teacher/rating_bloc/ratings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../app.dart';

class TeacherRatingPage extends StatefulWidget {
  const TeacherRatingPage({Key? key}) : super(key: key);

  @override
  _TeacherRatingPageState createState() => _TeacherRatingPageState();
}

class _TeacherRatingPageState extends State<TeacherRatingPage> {
  late String teacherName;
  List<Tab> _tabs = [];
  List<RatingsView> _tabContent = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    teacherName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: header(context, isMenu: false),
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
                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                      radius: 50,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.ratings ?? 'Ratings',
                      style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'addRating'),
                      child: Text(
                        "+",
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: BlocProvider(
                      create: (context) => CoursesCubit()..getTeacherCourses(teacherName),
                      child: BlocBuilder<CoursesCubit, CoursesState>(
                        builder: (context, state) {
                          if (state is ListCoursesSuccess) {
                            _createTabs(state.courses);
                            print(state.courses);
                            return DefaultTabController(
                                length: state.courses.length,
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
                                              indicatorColor: Color(0xFFB4E7B6),
                                              labelColor: Colors.black,
                                              labelStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                                              tabs: _tabs,
                                            )
                                          ],
                                        ),
                                        automaticallyImplyLeading: false,
                                      ),
                                      body: TabBarView(
                                        children: _tabContent,
                                      )
                                  ),
                            );
                          } else if (state is ListCoursesFailure) {
                            return Center(child: Text(state.exception.toString()));
                          } else {
                            return LoadingView();
                          }
                        },
                      ),
                    ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: homeButton(context),
                ),
              ],
            ),
          ),
      );
  }

  void _createTabs(List<CourseData> courses){
    for(var course in courses){
      _tabs.add(Tab(text: course.name));
      _tabContent.add(RatingsView(teacherName: teacherName, courseID: course.id, courseName: course.name));
    }
  }
}

class RatingsView extends StatefulWidget {
  final String teacherName;
  final String courseID;
  final String courseName;
  RatingsView({required this.teacherName, required this.courseID, required this.courseName});

  @override
  _RatingsViewState createState() => _RatingsViewState();
}

class _RatingsViewState extends State<RatingsView> {
  double _rating = 0.0;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RatingsCubit>(context)..getRatings(widget.teacherName, widget.courseID);
    BlocProvider.of<CommentsCubit>(context)..getComments(widget.teacherName, widget.courseID);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: BlocBuilder<RatingsCubit, RatingsState>(
                      builder: (context, state) {
                    if (state is GetRatingsSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${state.rating.ratingNum} ratings",
                            style: TextStyle(fontFamily: 'Glory', fontSize: 24, color: Colors.black),
                          ),
                          RatingBar(
                            initialRating: state.rating.rating,
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
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                              BlocProvider.of<RatingsCubit>(context).createRating(widget.teacherName, widget.courseID, rating);
                            },
                          )
                        ],
                      );
                    } else if (state is GetRatingsFailure) {
                      return Center(child: Text(state.exception.toString()));
                    } else {
                      return LoadingView();
                    }
                  }),
                ),
            BlocBuilder<CommentsCubit, CommentsState>(
                  builder: (context, state) {
                    if (state is ListCommentsSuccess) {
                      return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: state.comments
                              .map((comment) => CommentItem(comment: comment))
                              .toList(),

                      );
                    } else if (state is ListCommentsFailure) {
                      return Center(child: Text(state.exception.toString()));
                    } else {
                      return LoadingView();
                    }
                  },
                ),
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
      color: Color(0xFFC7E5C8),
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
                    TextStyle(fontFamily: 'Glory', fontSize: 16, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}


