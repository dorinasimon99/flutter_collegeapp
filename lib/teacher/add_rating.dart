import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/teacher/user_bloc/user_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddRatingPage extends StatefulWidget {
  const AddRatingPage({Key? key}) : super(key: key);

  @override
  _AddRatingPageState createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  String _currentUserName = "";
  List<bool> isSelected = [false];

  @override
  void initState(){
    getUsername();
    super.initState();
  }

  void getUsername() async {
    var username = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    if(username != null){
      setState(() {
        _currentUserName = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersCubit>(context)..getUserByUsername(_currentUserName);
    return Scaffold(
      appBar: header(context, isMenu: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)?.add_rating ?? 'Add rating',
              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
            ),
            ToggleButtons(
              children: [
                Text(
                  AppLocalizations.of(context)?.add_rating ?? 'Add rating',
                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                )
              ],
              onPressed: (int index) {
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
}
