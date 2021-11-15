import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/users/user_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/UserData.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData? user;
  var backgroundImage;
  final ImagePicker _picker = ImagePicker();
  String? _selectedImage;
  bool _editing = false;
  var _nameController = TextEditingController();
  var _semesterController = TextEditingController();

  void _getUser() async {
    var username = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    if(username != null){
      BlocProvider.of<UsersCubit>(context)..getUserByUsername(username);
    }
  }

  @override
  void initState(){
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)?.my_profile ?? 'My profile',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                  ),
                  _editing ? IconButton(
                      onPressed: (){
                        if(_editing){ _saveUser(); }
                      },
                      icon: Icon(Icons.check, size: 40, color: Colors.black)
                  ) : IconButton(
                      onPressed: (){
                        setState(() {
                          _editing = !_editing;
                          _nameController.text = user?.name ?? '';
                          _semesterController.text = user?.actualSemester.toString() ?? '';
                        });
                      },
                      icon: Icon(Icons.edit, size: 40, color: Colors.black)
                  )
                ],
              ),
              !kIsWeb && defaultTargetPlatform == TargetPlatform.android ? FutureBuilder(
                future: retrieveLostData(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(_selectedImage != null){
                      backgroundImage = FileImage(File(_selectedImage ?? ''));
                    }
                  }
                  return _avatar();
                },
              ) : _avatar(),
              _editing ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomTextFormField(_nameController, TextInputType.name),
              ) : Text(
                user?.name ?? '',
                style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)?.actual_semester ?? 'Actual semester'}:',
                      style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                    ),
                    _editing ? Flexible(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(_semesterController, TextInputType.number),
                    ))
                     : Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                       child: Text(
                        '${user?.actualSemester ?? ''}',
                        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                    ),
                     ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedFile?.path;
    });
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _selectedImage = response.file?.path;
      });
    } else {
      debugPrint('Retrieve lost data is null: ${response.exception?.code}');
    }
  }

  void _saveUser(){
    var newUser = user?.copyWith(
      avatar: _selectedImage,
      name: _nameController.text.trim(),
      actualSemester: int.parse(_semesterController.text.trim())
    );
    if(newUser != null){
      BlocProvider.of<UsersCubit>(context)..updateUser(newUser);
    }
  }

  Widget _avatar() {
    return BlocListener<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is GetUserSuccess) {
            if (state.user.avatar != null) {
              setState(() {
                backgroundImage = NetworkImage(state.user.avatar!);
                user = state.user;
              });
            } else {
              setState(() {
                backgroundImage = AssetImage("assets/avatar.png");
                user = state.user;
              });
            }
          } else if (state is GetUserFailure) {
            showErrorAlert(state.exception.toString(), context);
          } else if(state is UpdateUserSuccess){
            showSnackBar(context, AppLocalizations.of(context)?.profile_saved ?? 'Profile saved');
          } else if(state is UpdateUserFailure){
            showErrorAlert(state.exception.toString(), context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: backgroundImage,
                radius: 70,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Resources.customColors.snackBarGreen,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          border: Border.all(color: Colors.black, width: 3.0)),
                      child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined,
                              size: 30, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              _editing = true;
                            });
                            _selectImage();
                          }),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        )
    );
  }
}
