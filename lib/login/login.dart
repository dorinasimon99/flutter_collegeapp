import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  bool isSignedIn = false;

  @override
  void dispose(){
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _userNameController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 20,
                  style: TextStyle(fontFamily: "Glory", fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)?.username,
                      labelStyle: TextStyle(fontFamily: "Glory", fontWeight: FontWeight.w700, color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 20,
                  style: TextStyle(fontFamily: "Glory", fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)?.password,
                      labelStyle: TextStyle(fontFamily: "Glory", fontWeight: FontWeight.w700, color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MaterialButton(
                      onPressed: _signIn,
                      color: Color(0xFFB4E7B6),
                      child: Text(
                          AppLocalizations.of(context)?.signin.toUpperCase() ?? "",
                          style: TextStyle(fontFamily: "Glory", fontWeight: FontWeight.w700)
                      )
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.or ?? "",
                  style: TextStyle(fontFamily: "Glory", color: Color(0xFFC8C8C8)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MaterialButton(
                      onPressed: _signUp,
                      color: Color(0xFFD7FFD9),
                      child: Text(
                          AppLocalizations.of(context)?.signup.toUpperCase() ?? "",
                          style: TextStyle(fontFamily: "Glory", fontWeight: FontWeight.w700)
                      )
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }

  void _signIn() async{
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: _userNameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if(res.isSignedIn){
        Navigator.pushNamed(context, 'home');
      }
      LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, res.isSignedIn);
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void _signUp() async {

  }
}
