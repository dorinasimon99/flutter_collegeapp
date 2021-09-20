import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/home/home.dart';
import 'package:flutter_collegeapp/menu/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'menu': (context) => MenuPage()
      },
    );
  }
}
