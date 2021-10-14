import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/courses/CoursesCubit.dart';
import 'package:flutter_collegeapp/home/home.dart';
import 'package:flutter_collegeapp/login/login.dart';
import 'package:intl/intl.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isLoggedIn = false;
  String today = DateFormat('EEEE').format(DateTime.now());

  @override
  void initState(){
    super.initState();
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesCubit()..getTodayCoursesFromAPI(today),
      child: isLoggedIn ? HomePage() : LoginPage(),
    );
  }

  Future<void> _isLoggedIn() async {
    var getLoggedIn = await LocalStorage.localStorage.readBool(LocalStorage.KEY_IS_SIGNED_IN);
    setState(() {
      isLoggedIn = getLoggedIn;
    });
  }
}
