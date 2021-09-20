import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MenuPage())),
          icon: Image.asset('assets/hamburger.png'),
          iconSize: 120,
        ),
        toolbarHeight: 100.0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.today ?? 'Today',
                style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, i){
                    return Card(
                      color: Color(0xFFC7E5C8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CourseName",
                                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                                ),
                                Text(
                                  "3 todo",
                                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 24, color: Colors.black),
                                )
                              ],
                            ),
                            Text(
                              "10:15 - 12:00",
                              style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
