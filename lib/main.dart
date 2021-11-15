import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_cubit.dart';
import 'package:flutter_collegeapp/home/today_lessons_list.dart';
import 'package:flutter_collegeapp/lesson/add_lesson.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_collegeapp/profile/profile.dart';
import 'package:flutter_collegeapp/quiz/add_quiz.dart';
import 'package:flutter_collegeapp/quiz/quizzes.dart';
import 'package:flutter_collegeapp/sign_up/sign_up.dart';
import 'package:flutter_collegeapp/statistics/statistics.dart';
import 'package:flutter_collegeapp/study_cards/add_card.dart';
import 'package:flutter_collegeapp/bloc/cards/card_cubit.dart';
import 'package:flutter_collegeapp/study_cards/learn_study_cards.dart';
import 'package:flutter_collegeapp/study_cards/study_cards.dart';
import 'package:flutter_collegeapp/teacher/add_rating.dart';
import 'package:flutter_collegeapp/bloc/comments/comment_cubit.dart';
import 'package:flutter_collegeapp/bloc/ratings/ratings_cubit.dart';
import 'package:flutter_collegeapp/teacher/teacher_ratings.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/timetable/timetable.dart';
import 'package:flutter_collegeapp/todos/add_todo.dart';
import 'app.dart';
import 'courses/add_course.dart';
import 'courses/course_details.dart';
import 'courses/courses.dart';
import 'bloc/courses/courses_cubit.dart';
import 'bloc/teachers/teachers_cubit.dart';
import 'bloc/todos/todos_cubit.dart';
import 'home/home.dart';
import 'lesson/lesson.dart';
import 'bloc/lessons/lesson_cubit.dart';
import 'bloc/quizzes/quiz_cubit.dart';

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
              child: CourseDetailsPage(),
            ),
            BlocProvider(
              create: (context) => TodosCubit(),
              child: TodoItem(todo: null),
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
              child: RatingsView(courseName: '', teacherName: '', courseCode: ''),
            ),
            BlocProvider(
              create: (context) => RatingsCubit(),
              child: AddRatingPage(),
            ),
            BlocProvider(
              create: (context) => CommentsCubit(),
              child: RatingsView(courseName: '', teacherName: '', courseCode: ''),
            ),
            BlocProvider(
              create: (context) => CommentsCubit(),
              child: AddRatingPage(),
            ),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: HomePage(),
            ),
            BlocProvider(
              create: (context) => LessonsCubit(),
              child: TimetablePage(),
            ),
            BlocProvider(
              create: (context) => TodosCubit(),
              child: TimetablePage(),
            ),
            BlocProvider(
              create: (context) => QuizzesCubit(),
              child: AddQuizPage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: AddCardPage(),
            ),
            BlocProvider(
              create: (context) => CardsCubit(),
              child: AddCardPage(),
            ),
            BlocProvider(
              create: (context) => UserCoursesCubit(),
              child: StatisticsPage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: StatisticsPage(),
            ),
            BlocProvider(
              create: (context) => LessonsCubit(),
              child: LessonsList(),
            ),
            BlocProvider(
              create: (context) => TodosCubit(),
              child: LessonItem(),
            ),
            BlocProvider(
              create: (context) => LessonsCubit(),
              child: AddLessonPage(),
            ),
            BlocProvider(
              create: (context) => CardsCubit(),
              child: LearnStudyCardsPage(),
            ),
            BlocProvider(
              create: (context) => LessonsCubit(),
              child: CourseDetailsPage(),
            ),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: SignUpPage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: CourseDetailsPage(),
            ),
            BlocProvider(
              create: (context) => TeachersCubit(),
              child: CourseDetailsPage(),
            ),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: MenuPage(),
            ),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: ProfilePage(),
            ),
            BlocProvider(
              create: (context) => QuizzesCubit(),
              child: QuizzesPage(),
            ),
            BlocProvider(
              create: (context) => LessonsCubit(),
              child: QuizzesPage(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: DeleteCourseDialog(),
            ),
            BlocProvider(
              create: (context) => CoursesCubit(),
              child: TeacherCoursesTabView(),
            ),
          ],
          child: App(),

  ));
}
