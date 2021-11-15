import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/LessonData.dart';
import 'package:flutter_collegeapp/models/UserCourse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({Key? key}) : super(key: key);

  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  String? courseCode;
  String? owner;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedDate = "";
  int _currentStartHour = 8;
  int _currentStartMinute = 15;
  int _currentEndHour = 10;
  int _currentEndMinute = 0;
  bool _editing = false;
  LessonData? editLesson;

  void _setEditing(LessonData editLesson){
    setState(() {
      _editing = true;
      _titleController.text = editLesson.title;
      _descriptionController.text = editLesson.description ?? '';
      _selectedDate = editLesson.date;
      _currentStartHour = int.parse(editLesson.time.split("-")[0].split(":")[0]);
      _currentStartMinute = int.parse(editLesson.time.split("-")[0].split(":")[1]);
      _currentEndHour = int.parse(editLesson.time.split("-")[1].split(":")[0]);
      _currentEndMinute = int.parse(editLesson.time.split("-")[1].split(":")[1]);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Object?> args = ModalRoute.of(context)?.settings.arguments as List<Object?>;
    var userCourse = args[0] as UserCourse;
    editLesson = args[1] as LessonData?;
    if(editLesson != null){
      _setEditing(editLesson!);
    }
    courseCode = userCourse.courseCode;
    owner = userCourse.username;
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _editing? AppLocalizations.of(context)?.edit_lesson ?? 'Edit lesson' :
                      AppLocalizations.of(context)?.add_lesson ?? 'Add lesson',
                      style: TextStyle(
                          fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                    ),
                    BlocListener<LessonsCubit, LessonsState>(
                      listener: (context, state) {
                        if(state is CreateLessonSuccess){
                          showSnackBar(context, AppLocalizations.of(context)?.lesson_created ?? 'Lesson created', onActionPressed: () => Navigator.pop(context));
                        } else if(state is CreateLessonFailure){
                          showErrorAlert(state.exception.toString(), context);
                        } else if(state is UpdateLessonSuccess){
                          showSnackBar(context, AppLocalizations.of(context)?.lesson_created ?? 'Lesson created', onActionPressed: () => Navigator.pop(context));
                        } else if(state is UpdateLessonFailure){
                          showErrorAlert(state.exception.toString(), context);
                        }
                      },
                      child: IconButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()){
                            _saveLesson();
                          }
                        },
                        icon: Icon(Icons.check, color: Color(0xFFA5D6A7), size: 45),
                      )
                    ),
                  ],
                ),
                TextFormField(
                  controller: _titleController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 24,
                  minLines: 1,
                  maxLines: 2,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.title ?? "Title",
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.of(context)?.empty_field ?? "Please enter some text";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(_descriptionController, TextInputType.text, hintText: AppLocalizations.of(context)?.description ?? "Description"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _selectedDate,
                          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () => _selectDate(context),
                        color: Resources.customColors.cardGreen,
                        child: Text(
                          AppLocalizations.of(context)?.add_date.toUpperCase() ?? 'DATE',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                TimePicker(
                    context, _currentStartHour, _currentStartMinute, _currentEndHour, _currentEndMinute,
                        (value){setState(() {_currentStartHour = value;});},
                        (value){setState(() {_currentStartMinute = value;});},
                        (value){setState(() {_currentEndHour = value;});},
                        (value){setState(() {_currentEndMinute = value;});}
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+5)
    );
    if(picked != null && picked != DateTime.now()){
      setState(() {
        _selectedDate = DateFormat('yyyy.MM.dd.').format(picked);
      });
    }
  }

  void _saveLesson(){
    if(owner != null && courseCode != null){
      if(_editing){
        var lesson = editLesson!.copyWith(
            date: _selectedDate,
            time: '$_currentStartHour:${addZero(_currentStartMinute)}-$_currentEndHour:${addZero(_currentEndMinute)}',
            owner: owner!,
            courseCode: courseCode!,
            title: _titleController.text,
            description: _descriptionController.text
        );
        BlocProvider.of<LessonsCubit>(context)..updateLesson(lesson);
      } else {
        var lesson = LessonData(
            date: _selectedDate,
            time: '$_currentStartHour:${addZero(_currentStartMinute)}-$_currentEndHour:${addZero(_currentEndMinute)}',
            owner: owner!,
            courseCode: courseCode!,
            title: _titleController.text,
            description: _descriptionController.text
        );
        BlocProvider.of<LessonsCubit>(context)..createLesson(lesson);
      }
    }
  }
}
