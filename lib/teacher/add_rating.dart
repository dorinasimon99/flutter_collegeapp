import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_collegeapp/bloc/comments/comment_cubit.dart';
import 'package:flutter_collegeapp/bloc/ratings/ratings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddRatingPage extends StatefulWidget {
  const AddRatingPage({Key? key}) : super(key: key);

  @override
  _AddRatingPageState createState() => _AddRatingPageState();
}

class _AddRatingPageState extends State<AddRatingPage> {
  String _currentUserName = "";
  List<bool> isSelected = [false];
  var _commentController = TextEditingController();
  UserCourse? _args;
  double _rating = 0.0;

  @override
  void initState(){
    getUserName();
    super.initState();
  }

  void getUserName() async {
    var userName = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_NAME);
    if(userName != null){
      setState(() {
        _currentUserName = userName;
      });
    }
  }

  @override
  void dispose(){
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as UserCourse;
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)?.add_rating ?? 'Add rating',
                  style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                ),
              ),
              ToggleButtons(
                borderColor: Colors.transparent,
                children: [
                  Text(
                    isSelected[0] ? _currentUserName : 'Anonymus',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                  )
                ],
                onPressed: (int index) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
                isSelected: isSelected,
              ),
              TextField(
                controller: _commentController,
                cursorColor: Resources.customColors.cursorGreen,
                cursorHeight: 24,
                style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                minLines: 1,
                maxLines: 20,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.comment ?? 'Comment',
                    hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: RatingBar(
                  initialRating: 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Color(0xFFA5D6A7),
                    ),
                    empty: Icon(Icons.star_border, color: Color(0xFFA5D6A7),
                    ),
                    half: Icon(Icons.star_half, color: Color(0xFFA5D6A7),
                    ),
                  ),
                  glow: false,
                  itemSize: 40,
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Resources.customColors.cardGreen,
                      onPressed: (){
                        _save();
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)?.save.toUpperCase() ?? 'Save',
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if(_args != null && _rating != 0.0){
      if(_rating != 0.0){
        BlocProvider.of<RatingsCubit>(context)..updateRating(_args!.name, _args!.courseCode, _rating);
      }
      if(_commentController.text.isNotEmpty){
        CommentData newComment = CommentData(courseCode: _args!.courseCode, teachername: _args!.name, comment: _commentController.text, name: isSelected[0] ? _currentUserName : null);
        BlocProvider.of<CommentsCubit>(context)..createComment(newComment);
      }
    }
  }
}
