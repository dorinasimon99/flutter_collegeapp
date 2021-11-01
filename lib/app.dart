import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/courses/add_course.dart';
import 'package:flutter_collegeapp/courses/course_details.dart';
import 'package:flutter_collegeapp/courses/courses.dart';
import 'package:flutter_collegeapp/courses/todos/add_todo.dart';
import 'package:flutter_collegeapp/home/home.dart';
import 'package:flutter_collegeapp/lesson/lesson.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_collegeapp/root/root.dart';
import 'package:flutter_collegeapp/sign_up/sign_up.dart';
import 'package:flutter_collegeapp/study_cards/learn_study_cards.dart';
import 'package:flutter_collegeapp/study_cards/study_cards.dart';
import 'package:flutter_collegeapp/teacher/add_rating.dart';
import 'package:flutter_collegeapp/teacher/teacher_ratings.dart';
import 'package:flutter_collegeapp/timetable/timetable.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'amplifyconfiguration.dart';
import 'login/login.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _amplifyConfigured = false;

  @override
  void initState(){
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "CollegeApp",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('en_US', ''),
        Locale('hu', '')
      ],
      initialRoute: 'root',
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
        'signUp': (context) => SignUpPage()
      },
      home: _amplifyConfigured ? RootPage() : LoadingView()
    );
  }

  Future<void> _configureAmplify() async{
    Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAPI()]);
    try {
      await Amplify.configure(amplifyconfig);
    } catch(e){
      print('An error occurred while configuring Amplify: $e');
    }

    setState(() {
      _amplifyConfigured = true;
    });

  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Color(0xFFC7E5C8)),
    );
  }
}
