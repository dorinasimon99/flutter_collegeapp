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
import 'package:flutter_collegeapp/models/ModelProvider.dart';
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
  var _role = Roles.instance.student;
  var _actualSemesterController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSignUpComplete = false;
  bool _loading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose(){
    _userNameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    _confirmController.dispose();
    _actualSemesterController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, isMenu: false),
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
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  keyboardType: TextInputType.name,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.name ?? "Name",
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _userNameController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.username ?? "Username",
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_passwordVisible,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.password ?? "Password",
                    hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                    ),
                    suffix: IconButton(
                      icon: _passwordVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_confirmPasswordVisible,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.confirm_password ?? "Confirm password",
                    hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                    ),
                    suffix: IconButton(
                      icon: _confirmPasswordVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    } else if(value != _passwordController.text){
                      return AppLocalizations.of(context)?.not_match ?? 'Password and confirm password does not match!';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)?.role ?? 'Role'}:',
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24, color: Color(0xFF828282)),
                    ),
                    DropdownButton<String>(
                      value: _role,
                      items: Roles.instance.values.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(
                          value.toString(),
                          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
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
                  child: Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)?.actual_semester ?? 'Actual semester'}:',
                        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24, color: Color(0xFF828282)),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _actualSemesterController,
                            cursorColor: Resources.customColors.cursorGreen,
                            cursorHeight: 24,
                            keyboardType: TextInputType.number,
                            style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                                )
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)?.empty_field ?? 'Please add a value';
                              }
                              return null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  keyboardType: TextInputType.emailAddress,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.email ?? "Email address",
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _loading ? CircularProgressIndicator(color: Colors.black) : MaterialButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          setState(() {
                            _loading = !_loading;
                          });
                          _signUp();
                        }
                      },
                      color: Resources.customColors.cursorGreen,
                      child: Text(
                          AppLocalizations.of(context)?.signup.toUpperCase() ?? "SIGN UP",
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24)
                      )
                  ),
                ),
                TextFormField(
                  controller: _confirmController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  keyboardType: TextInputType.number,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.confirmation_code ?? "Confirmation code",
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MaterialButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          _confirmSignUp();
                        }
                      },
                      color: Color(0xFFD7FFD9),
                      child: Text(
                          AppLocalizations.of(context)?.send_confirmtion_code.toUpperCase() ?? "SEND",
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

  void _confirmSignUp() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: _userNameController.text.trim(),
          confirmationCode: _confirmController.text.trim()
      );
      if(res.isSignUpComplete){
        await LocalStorage.localStorage.saveBool(LocalStorage.KEY_IS_SIGNED_IN, res.isSignUpComplete);
        await LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_USER_NAME, _userNameController.text.trim());
        await LocalStorage.localStorage.saveString(LocalStorage.SIGNED_IN_ROLE, _role.trim());
        var user = UserData(
            username: _userNameController.text.trim(),
            role: _role.trim(),
            name: _nameController.text.trim(),
            actualSemester: int.parse(_actualSemesterController.text.trim())
        );
        BlocProvider.of<UsersCubit>(context)..createUser(user);
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
      SignUpResult result = await Amplify.Auth.signUp(
          username: _userNameController.text.trim(),
          password: _passwordController.text.trim(),
          options: CognitoSignUpOptions(
              userAttributes: userAttributes
          )
      );
      setState(() {
        _loading = false;
      });
      print(result);
    } on AuthException catch (e) {
      setState(() {
        _loading = false;
      });
      showErrorAlert(e.message, context);
    }
  }
}
