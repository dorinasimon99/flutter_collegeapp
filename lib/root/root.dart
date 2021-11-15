import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/home/home.dart';
import 'package:flutter_collegeapp/login/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isLoggedIn = false;
  bool networkIsUp = false;
  bool _showAlert = false;

  @override
  void initState(){
    super.initState();
    _isLoggedIn();
    Connectivity().onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.none){
        setState(() {
          _showAlert = true;
        });
      } else if(event == ConnectivityResult.mobile || event == ConnectivityResult.wifi){
        setState(() {
          _showAlert = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoggedIn ? HomePage() : LoginPage(),
        _showAlert ? Card(
          child: SizedBox(
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: ListTile(
                leading: Icon(Icons.error_outline),
                title: Text(
                  AppLocalizations.of(context)?.no_internet ?? 'No internet connection!',
                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _showAlert = false;
                    });
                  },
                  icon: Icon(Icons.clear),
                ),
                tileColor: Resources.customColors.alertRed,
              ),
            ),
          ),
        ) : SizedBox()
      ],
    );
  }

  Future<void> _isLoggedIn() async {
    var getLoggedIn = await LocalStorage.localStorage.readBool(LocalStorage.KEY_IS_SIGNED_IN);
    setState(() {
      isLoggedIn = getLoggedIn;
    });
  }
}
