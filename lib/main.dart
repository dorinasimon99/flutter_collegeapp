import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/login/login.dart';
import 'package:flutter_collegeapp/study_cards/card_cubit.dart';
import 'package:flutter_collegeapp/study_cards/study_cards.dart';
import 'package:flutter_collegeapp/teacher/add_rating.dart';
import 'package:flutter_collegeapp/teacher/comment_bloc/comment_cubit.dart';
import 'package:flutter_collegeapp/teacher/rating_bloc/ratings_cubit.dart';
import 'package:flutter_collegeapp/teacher/teacher_ratings.dart';
import 'package:flutter_collegeapp/teacher/user_bloc/user_cubit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'app.dart';
import 'courses/add_course.dart';
import 'courses/course_details.dart';
import 'courses/courses.dart';
import 'courses/courses_cubit.dart';
import 'courses/teachers/teachers_cubit.dart';
import 'courses/todos/add_todo.dart';
import 'courses/todos/todos_cubit.dart';
import 'home/home.dart';
import 'lesson/lesson.dart';
import 'lesson/lesson_cubit.dart';
import 'lesson/quiz_bloc/quiz_cubit.dart';

void main() {
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LessonsCubit(),
              child: HomePage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: CoursesPage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: AddCoursePage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: TeacherRatingPage(),
            ),
            BlocProvider(
              create: (context) => TeachersCubit(),
              child: TeachersList(),
            ),
            BlocProvider(
              create: (context) => TodosCubit(),
              child: TodosList(),
            ),
            BlocProvider(
              create: (context) => TodosCubit(),
              child: AddTodoPage(),
            ),
            BlocProvider(
              create: (context) => QuizzesCubit(),
              child: LessonPage(),
            ),
            BlocProvider(
              create: (context) => CardsCubit(),
              child: StudyCardsPage(),
            ),
            BlocProvider(
              create: (context) => RatingsCubit(),
              child: RatingsView(courseName: '', teacherName: '', courseID: ''),
            ),
            BlocProvider(
              create: (context) => RatingsCubit(),
              child: AddRatingPage(),
            ),
            BlocProvider(
              create: (context) => CommentsCubit(),
              child: RatingsView(courseName: '', teacherName: '', courseID: ''),
            ),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: AddRatingPage(),
            ),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: LoginPage(),
            ),
          ],
          child: App(),

  ));
}
