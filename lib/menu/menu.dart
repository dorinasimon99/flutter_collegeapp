import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Image.asset('assets/back.png'),
            iconSize: 120,
            onPressed: (){
              Navigator.of(context).pop();
            },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child:
                          Text(
                            AppLocalizations.of(context)?.timetable ?? 'Timetable',
                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                          ),

                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        AppLocalizations.of(context)?.courses ?? 'Courses',
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        AppLocalizations.of(context)?.statistics ?? 'Statistics',
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        AppLocalizations.of(context)?.study_cards ?? 'Study cards',
                        style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 30, color: Colors.black),
                      ),
                    ),
              ]),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
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
}
