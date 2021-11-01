import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuPage extends StatefulWidget {
  MenuPage();

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  _MenuPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isMenu: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/timetable.png'),
                            iconSize: 45,
                            onPressed: () => Navigator.pushNamed(context, 'timetable')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)?.timetable ?? 'Timetable',
                              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Image.asset('assets/courses.png'),
                              iconSize: 45,
                              onPressed: () => Navigator.pushNamed(context, 'courses')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)?.courses ?? 'Courses',
                              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Image.asset('assets/stats.png'),
                              iconSize: 45,
                              onPressed: (){}),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)?.statistics ?? 'Statistics',
                              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Image.asset('assets/cards.png'),
                              iconSize: 45,
                              onPressed: () => Navigator.pushNamed(context, 'cards')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)?.study_cards ?? 'Study cards',
                              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                ]),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/logout.png'),
                          iconSize: 45,
                          onPressed: _signOut,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
                          child: Text(
                            AppLocalizations.of(context)?.logout ?? 'Logout',
                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  void _signOut() async{
    try {
      await Amplify.Auth.signOut();
      LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, false);
      Navigator.popUntil(context, ModalRoute.withName('root'));
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
