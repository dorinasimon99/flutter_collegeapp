import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/teacher/user_bloc/user_cubit.dart';
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
                  cursorHeight: 24,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.username ?? "Username",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 24,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.password ?? "Password",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
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
                          AppLocalizations.of(context)?.signin.toUpperCase() ?? "SIGN IN",
                          style: TextStyle(fontFamily: "Glory-Semi", fontSize: 24)
                      )
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.or ?? "or",
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Color(0xFFC8C8C8)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MaterialButton(
                      onPressed: () => Navigator.pushNamed(context, 'signUp'),
                      color: Color(0xFFD7FFD9),
                      child: Text(
                          AppLocalizations.of(context)?.signup.toUpperCase() ?? "SIGN UP",
                          style: TextStyle(fontFamily: "Glory-Semi", fontSize: 24)
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
        LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, res.isSignedIn);
        LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_USER_NAME, _userNameController.text.trim());
        LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_ROLE, _getRole(_userNameController.text.trim()));
        Navigator.pushNamed(context, 'home');
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  String _getRole(String username) {
    BlocProvider.of<UsersCubit>(context).getUserByUsername(username);
    String role = "";
    BlocListener(
      bloc: UsersCubit(),
      listener: (BuildContext context, state) {
        if(state is GetUserSuccess){
          role = state.user.role;
        }
      },
    );
    return role;
  }
}
