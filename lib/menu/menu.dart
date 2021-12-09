import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/UserData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuPage extends StatefulWidget {
  MenuPage();

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  UserData? user;
  var backgroundImage;

  void _getUser() async {
    var username = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    if(username != null){
      BlocProvider.of<UsersCubit>(context)..getUserByUsername(username);
    }
  }

  @override
  void initState(){
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, isMenu: false),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Flex(direction: Axis.vertical, children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'profile',
                          arguments: user),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BlocListener<UsersCubit, UsersState>(
                              listener: (context, state) {
                                if (state is GetUserSuccess) {
                                  if (state.user.avatar != null) {
                                    setState(() {
                                      backgroundImage = FileImage(File(state.user.avatar!));
                                      user = state.user;
                                    });
                                  } else {
                                    setState(() {
                                      backgroundImage = AssetImage("assets/avatar.png");
                                      user = state.user;
                                    });
                                  }
                                } else if (state is GetUserFailure) {
                                  showErrorAlert(state.exception.toString(), context);
                                } else if(state is UpdateUserSuccess){
                                  if (state.user.avatar != null) {
                                    setState(() {
                                      backgroundImage = FileImage(File(state.user.avatar!));
                                      user = state.user;
                                    });
                                  } else {
                                    setState(() {
                                      backgroundImage = AssetImage("assets/avatar.png");
                                      user = state.user;
                                    });
                                  }
                                } else if(state is UpdateUserFailure){
                                  showErrorAlert(state.exception.toString(), context);
                                }
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: CircleAvatar(
                                        backgroundImage: backgroundImage,
                                        radius: 40,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user?.name ?? '',
                                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)?.my_profile ?? 'My profile',
                                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 25),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ]
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'timetable'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/timetable.png', width: 45),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppLocalizations.of(context)?.timetable ?? 'Timetable',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'courses'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/courses.png', width: 45),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppLocalizations.of(context)?.courses ?? 'Courses',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'statistics'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/stats.png', width: 45),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppLocalizations.of(context)?.statistics ?? 'Statistics',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'cards'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/cards.png', width: 45),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          AppLocalizations.of(context)?.study_cards ?? 'Study cards',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              user != null && user!.role == Roles.instance.teacher ? Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'quizzes'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/cards.png', width: 45),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            AppLocalizations.of(context)?.quizzes ?? 'Quizzes',
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
              ) : Container(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: TextButton(
                        onPressed: _signOut,
                        child: Row(
                          children: [
                            Image.asset('assets/logout.png', width: 45),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                AppLocalizations.of(context)?.logout ?? 'Logout',
                                style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  void _signOut() async{
    try {
      await Amplify.Auth.signOut();
      LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, false);
      Navigator.pushNamedAndRemoveUntil(context, 'root', (route) => false);
    } on AuthException catch (e) {
      showErrorAlert(e.message, context);
    }
  }
}
