import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/resources.dart';
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
  bool _passwordVisible = false;
  var _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(_userNameController, TextInputType.text, hintText: AppLocalizations.of(context)?.username ?? "Username"),
                  TextFormField(
                    controller: _passwordController,
                    cursorColor: Resources.customColors.cursorGreen,
                    cursorHeight: 20,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_passwordVisible,
                    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)?.password ?? "Password",
                        hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                        suffix: IconButton(
                          icon: _passwordVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          onPressed: (){
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: MaterialButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            BlocProvider.of<UsersCubit>(context)..getUserByUsername(_userNameController.text.trim());
                            _signIn();
                          }
                        },
                        color: Resources.customColors.cursorGreen,
                        child: Text(
                            AppLocalizations.of(context)?.signin.toUpperCase() ?? "SIGN IN",
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24)
                        )
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)?.or ?? "or",
                    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24, color: Color(0xFFC8C8C8)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: MaterialButton(
                        onPressed: () => Navigator.pushNamed(context, 'signUp'),
                        color: Color(0xFFD7FFD9),
                        child: Text(
                            AppLocalizations.of(context)?.signup.toUpperCase() ?? "SIGN UP",
                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24)
                        )
                    ),
                  )
                ],
              ),
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
        await Amplify.DataStore.start();
        Navigator.pushNamed(context, 'home');
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
