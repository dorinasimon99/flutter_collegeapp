import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/courses/add_course.dart';
import 'package:flutter_collegeapp/courses/course_details.dart';
import 'package:flutter_collegeapp/courses/courses.dart';
import 'package:flutter_collegeapp/courses/search_courses.dart';
import 'package:flutter_collegeapp/home/home.dart';
import 'package:flutter_collegeapp/lesson/add_lesson.dart';
import 'package:flutter_collegeapp/lesson/lesson.dart';
import 'package:flutter_collegeapp/lesson/lessons_list.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_collegeapp/profile/profile.dart';
import 'package:flutter_collegeapp/quiz/add_quiz.dart';
import 'package:flutter_collegeapp/quiz/quizzes.dart';
import 'package:flutter_collegeapp/root/root.dart';
import 'package:flutter_collegeapp/sign_up/sign_up.dart';
import 'package:flutter_collegeapp/statistics/statistics.dart';
import 'package:flutter_collegeapp/students/students.dart';
import 'package:flutter_collegeapp/study_cards/add_card.dart';
import 'package:flutter_collegeapp/study_cards/learn_study_cards.dart';
import 'package:flutter_collegeapp/study_cards/study_cards.dart';
import 'package:flutter_collegeapp/teacher/add_rating.dart';
import 'package:flutter_collegeapp/teacher/teacher_ratings.dart';
import 'package:flutter_collegeapp/timetable/timetable.dart';
import 'package:flutter_collegeapp/todos/add_todo.dart';
import 'amplifyconfiguration.dart';
import 'common/resources.dart';
import 'login/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _amplifyConfigured = false;
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyDataStore _datastorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);

  @override
  void initState(){
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "CollegeApp",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [
        Locale('en', ''),
        Locale('en_US', ''),
        Locale('hu', '')
      ],
      routes: {
        'root': (context) => RootPage(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'menu': (context) => MenuPage(),
        'timetable': (context) => TimetablePage(),
        'courses': (context) => CoursesPage(),
        'addCourse': (context) => AddCoursePage(),
        'courseDetails': (context) => CourseDetailsPage(),
        'teacherRatings': (context) => TeacherRatingPage(),
        'cards': (context) => StudyCardsPage(),
        'learn_cards': (context) => LearnStudyCardsPage(),
        'lesson': (context) => LessonPage(),
        'addTodo': (context) => AddTodoPage(),
        'addRating': (context) => AddRatingPage(),
        'signUp': (context) => SignUpPage(),
        'addQuiz': (context) => AddQuizPage(),
        'addCard': (context) => AddCardPage(),
        'statistics': (context) => StatisticsPage(),
        'addLesson': (context) => AddLessonPage(),
        'profile': (context) => ProfilePage(),
        'searchCourse': (context) => SearchCoursesPage(),
        'quizzes': (context) => QuizzesPage(),
        'lessons': (context) => LessonsList(),
        'students': (context) => StudentsPage()
      },
      home: _amplifyConfigured ? RootPage() : LoadingView()
    );
  }

  Future<void> _initializeApp() async {

    await _configureAmplify();

    setState(() {
        _amplifyConfigured = true;
      });
  }

  Future<void> _configureAmplify() async{
    try {
      await Amplify.addPlugin(_authPlugin);
      await Amplify.addPlugin(_datastorePlugin);
      await Amplify.addPlugin(_apiPlugin);
      await Amplify.configure(amplifyconfig);
    } catch(e){
      print('An error occurred while configuring Amplify: $e');
    }
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Resources.customColors.cardGreen),
    );
  }
}
