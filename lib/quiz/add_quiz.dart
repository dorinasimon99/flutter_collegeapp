import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/bloc/quizzes/quiz_cubit.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddQuizPage extends StatefulWidget {
  const AddQuizPage({Key? key}) : super(key: key);

  @override
  _AddQuizPageState createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  var _titleController = TextEditingController();
  var _linkController = TextEditingController();
  var _descriptionController = TextEditingController();
  bool _isVisible = false;
  String? _lessonID;
  QuizData? _editQuiz;
  bool _editing = false;
  bool _refresh = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    _titleController.dispose();
    _linkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _getArgs(List<Object?> arguments){
    _lessonID = arguments[0] as String;
    if(arguments.length == 2){
      _editQuiz = arguments[1] as QuizData?;
    }

    if(_editQuiz != null){
      setState(() {
        _editing = true;
        _titleController.text = _editQuiz!.title;
        _linkController.text = _editQuiz!.link;
        _descriptionController.text = _editQuiz!.description ?? '';
        _isVisible = _editQuiz!.visible;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<Object?> args = ModalRoute.of(context)!.settings.arguments as List<Object?>;
    if(!_refresh){
      _getArgs(args);
    }
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _editing ? AppLocalizations.of(context)?.edit_quiz ?? 'Edit quiz' :
                    AppLocalizations.of(context)?.add_quiz ?? 'Add quiz',
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                  ),
                ),
                TextFormField(
                  controller: _titleController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 20,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.title ?? 'Title',
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _linkController,
                  cursorColor: Resources.customColors.cursorGreen,
                  cursorHeight: 20,
                  minLines: 1,
                  maxLines: 3,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.link ?? 'Link',
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      suffix: IconButton(
                        onPressed: _getClipBoard,
                        icon: Icon(Icons.paste),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Resources.customColors.cursorGreen)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(_descriptionController, TextInputType.text, hintText: AppLocalizations.of(context)?.description ?? 'Description', maxLines: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          '${AppLocalizations.of(context)?.visible ?? 'Visible'}:',
                          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                        ),
                      ),
                      Switch(
                            value: _isVisible,
                            onChanged: (visible) {
                              setState(() {
                                _refresh = true;
                                _isVisible = visible;
                              });},
                            activeTrackColor: Resources.customColors.cursorGreen,
                            activeColor: Colors.white,
                          ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocListener<QuizzesCubit, QuizzesState>(
                      listener: (context, state) {
                        if(state is CreateQuizSuccess){
                          showSnackBar(context, AppLocalizations.of(context)?.quiz_created ?? 'Quiz created', onActionPressed: () => Navigator.pop(context));
                        } else if(state is CreateQuizFailure){
                          showErrorAlert(state.exception.toString(), context);
                        } else if(state is UpdateQuizSuccess){
                          showSnackBar(context, AppLocalizations.of(context)?.quiz_updated ?? 'Quiz updated', onActionPressed: () => Navigator.pop(context));
                        } else if(state is UpdateQuizFailure){
                          showErrorAlert(state.exception.toString(), context);
                        }
                      },
                      child: MaterialButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _save();
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)?.save.toUpperCase() ?? 'SAVE',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                        ),
                      color: Resources.customColors.cursorGreen,
                    ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getClipBoard() async {
    ClipboardData? _data = await Clipboard.getData(Clipboard.kTextPlain);
    if(_data != null && _data.text != null){
      setState(() {
        _linkController.text = _data.text!;
      });
    }

  }

  void _save() {
    if(_lessonID != null){
      if(_editing){
        QuizData quiz = _editQuiz!.copyWith(title: _titleController.text, lessonID: _lessonID!,
            link: _linkController.text, visible: _isVisible,
            description: _descriptionController.text.isEmpty ? null : _descriptionController.text);
        BlocProvider.of<QuizzesCubit>(context)..updateQuiz(quiz);
      } else {
        QuizData quiz = QuizData(title: _titleController.text, lessonID: _lessonID!,
            link: _linkController.text, visible: _isVisible,
            description: _descriptionController.text.isEmpty ? null : _descriptionController.text);
        BlocProvider.of<QuizzesCubit>(context)..createQuiz(quiz);
      }
    }
  }
}