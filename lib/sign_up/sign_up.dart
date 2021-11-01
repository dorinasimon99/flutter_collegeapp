import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _nameController = TextEditingController();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _emailController = TextEditingController();
  var _confirmController = TextEditingController();
  var _role = "STUDENT";
  var _actualSemesterController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSignUpComplete = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isMenu: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 24,
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 24,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.password ?? "Password",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 24,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Confirm password",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if(value != _passwordController.text){
                      return 'Password and confirm password does not match!';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Role:',
                      style: TextStyle(fontFamily: "Glory-Semi", fontSize: 24, color: Color(0xFF828282)),
                    ),
                    DropdownButton<String>(
                      value: _role,
                      items: ["STUDENT", "TEACHER"].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(
                          value.toString(),
                          style: TextStyle(fontFamily: "Glory", fontSize: 20, color: Colors.black),
                        ));
                      }).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          _role = newValue!;
                        });
                      },
                    )
                  ],
                ),
                Container(
                  width: _role == "STUDENT" ? MediaQuery.of(context).size.width : 0,
                  child: Row(
                    children: [
                      Text(
                        'Actual semester:',
                        style: TextStyle(fontFamily: "Glory-Semi", fontSize: 24, color: Color(0xFF828282)),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _actualSemesterController,
                          cursorColor: Color(0xFFB4E7B6),
                          cursorHeight: 24,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFB4E7B6))
                              )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add a value';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 24,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: MaterialButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          _signUp();
                        }
                      },
                      color: Color(0xFFB4E7B6),
                      child: Text(
                          "SEND CONFIRMATION CODE",
                          style: TextStyle(fontFamily: "Glory-Semi", fontSize: 24)
                      )
                  ),
                ),
                TextFormField(
                  controller: _confirmController,
                  cursorColor: Color(0xFFB4E7B6),
                  cursorHeight: 24,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: "Glory", fontSize: 24, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Confirmation code",
                      hintStyle: TextStyle(fontFamily: "Glory-Semi", fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB4E7B6))
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MaterialButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          _sendConfirmationCode();
                        }
                      },
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
      ),
    );
  }

  void _sendConfirmationCode() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: _userNameController.text.trim(),
          confirmationCode: _confirmController.text.trim()
      );
      if(res.isSignUpComplete){
        LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, res.isSignUpComplete);
        LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_USER_NAME, _userNameController.text.trim());
        LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_ROLE, _role.trim());
        Navigator.pushNamed(context, 'home');
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void _signUp() async {
    try {
      Map<String, String> userAttributes = {
        'email': _emailController.text.trim(),
        'custom:role': _role,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: _userNameController.text.trim(),
          password: _passwordController.text.trim(),
          options: CognitoSignUpOptions(
              userAttributes: userAttributes
          )
      );
      if(res.isSignUpComplete){
        LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, res.isSignUpComplete);
        LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_USER_NAME, _userNameController.text.trim());
        LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_ROLE, _role.trim());
        Navigator.pushNamed(context, 'home');
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
