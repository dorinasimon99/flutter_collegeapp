import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/bloc/courses/courses_cubit.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CardData.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/bloc/cards/card_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCardPage extends StatefulWidget {
  AddCardPage();

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  List<CardItem> _cards = <CardItem>[];
  List<String> _questions = <String>[];
  List<String> _answers = <String>[];
  CourseData? _selectedCourse;
  var _titleController = TextEditingController();
  CardData? editCard;
  bool _editing = false;
  CourseData? _firstValue;
  bool _delete = false;
  String? _localUser;

  @override
  void initState(){
    super.initState();
    _getUser();
  }

  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();
  }

  void _setEditing(CardData _editable){
    _questions.addAll(_editable.questions);
    _answers.addAll(_editable.answers);
    if(_editable.title != null){
      _titleController.text = _editable.title!;
    }
    for(var i = 0; i < _editable.questions.length; i++){
      _cards.add(CardItem(i, false));
    }
    setState(() {
      _editing = true;
    });
  }

  void _getUser() async {
    var localUser = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    if(localUser != null){
      BlocProvider.of<CoursesCubit>(context)..getUserCourses(localUser);
      setState(() {
        _localUser = localUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    editCard = ModalRoute.of(context)!.settings.arguments as CardData?;
    if(!_delete && !_editing && editCard != null){
      _setEditing(editCard!);
    }
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _editing ? AppLocalizations.of(context)?.edit_study_card ?? 'Edit study card' :
                          AppLocalizations.of(context)?.add_card ?? 'Add study card',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _cards.add(CardItem(_cards.length, false));
                            _delete = false;
                          });
                        },
                        child: Text(
                          '+',
                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                        )
                      ),
                      BlocListener<CardsCubit, CardsState>(
                        listener: (context, state) {
                          if(state is CreateCardSuccess){
                            showSnackBar(context, AppLocalizations.of(context)?.card_created ?? 'Card created', onActionPressed: () => Navigator.pop(context, state.card));
                          } else if(state is CreateCardFailure){
                            showErrorAlert(state.exception.toString(), context);
                          } else if(state is UpdateCardSuccess){
                            showSnackBar(context, AppLocalizations.of(context)?.card_created ?? 'Card created', onActionPressed: () => Navigator.pop(context, state.card));
                          } else if(state is UpdateCardFailure){
                            showErrorAlert(state.exception.toString(), context);
                          } else if(state is DeleteCardSuccess){
                            Navigator.pop(context);
                          } else if(state is DeleteCardFailure){
                            showErrorAlert(state.exception.toString(), context);
                          }
                        },
                        child: IconButton(
                          onPressed: (){
                            _save();
                          },
                          icon: Icon(Icons.check, size: 35, color: Colors.black),
                        ),
                      ),
                      _editing && editCard?.isFavorite?.contains(_localUser) == true ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: _deleteCard,
                          icon: Icon(Icons.delete, size: 35),
                        ),
                      ) : Container()
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          cursorColor: Resources.customColors.cursorGreen,
                          cursorHeight: 20,
                          style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)?.title ?? "Title",
                              hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Resources.customColors.cursorGreen))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<CoursesCubit, CoursesState>(
                                builder: (context, state) {
                                  if (state is ListUsersCoursesSuccess) {
                                    if (editCard != null && _selectedCourse == null) {
                                      _firstValue = state.courses.firstWhere((element) => element.courseCode == editCard!.courseCode);
                                    } else if (editCard == null && _selectedCourse == null){
                                      _firstValue = state.courses[0];
                                    }
                                    return DropdownButton<CourseData>(
                                      value: _selectedCourse ?? _firstValue,
                                        items: state.courses.map<DropdownMenuItem<CourseData>>(
                                          (CourseData value) {
                                          return DropdownMenuItem<CourseData>(
                                            value: value,
                                            child: Text(
                                            value.name.toString(),
                                              style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                                            )
                                          );
                                      }).toList(),
                                      onChanged: (CourseData? newValue) {
                                        setState(() {
                                          _firstValue = null;
                                          _selectedCourse = newValue!;
                                        });
                                      },
                                    );
                                  } else if (state is ListUsersCoursesFailure) {
                                    return Center(child: Text(state.exception.toString()));
                                 } else
                                    return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _cards.length,
                              itemBuilder: (BuildContext context, int index) {
                                CardItem returnCard;
                                if (index < _questions.length) {
                                  returnCard = CardItem(index, true, onCardChanged: (newCardContent) {
                                    if (newCardContent.deleted) {
                                      setState(() {
                                        _cards.removeAt(newCardContent.index);
                                        if(_questions.length > newCardContent.index){
                                          _questions.removeAt(newCardContent.index);
                                        }
                                        if(_answers.length > newCardContent.index){
                                          _answers.removeAt(newCardContent.index);
                                        }
                                        _delete = true;
                                      });
                                    } else {
                                      setState(() {
                                        _questions[index] = newCardContent.question;
                                        _answers[index] = newCardContent.answer;
                                      });
                                    }
                                  }, question: editCard?.questions[index], answer: editCard?.answers[index]);
                                } else {
                                  returnCard = CardItem(index, false, onCardChanged: (newCardContent) {
                                    if (newCardContent.deleted) {
                                      setState(() {
                                        _cards.removeAt(newCardContent.index);
                                        if(_questions.length > newCardContent.index){
                                          _questions.removeAt(newCardContent.index);
                                        }
                                        if(_answers.length > newCardContent.index){
                                          _answers.removeAt(newCardContent.index);
                                        }
                                        _delete = true;
                                      });
                                    } else {
                                      setState(() {
                                        _questions.add(newCardContent.question);
                                        _answers.add(newCardContent.answer);
                                      });
                                    }
                                  });
                                }
                                _cards[index] = returnCard;
                                return returnCard;
                              },
                            ),
                          ),
                      ]
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  void _save() {
    if(_cards.any((element) => element.saved == false)){
      showSnackBar(context, AppLocalizations.of(context)?.unsaved_card ?? 'Unsaved card(s)!', color: Resources.customColors.alertRed);
    } else {
      if(editCard == null && _questions.isNotEmpty && _answers.isNotEmpty && _questions.length == _answers.length){
        if(_selectedCourse == null){
          _selectedCourse = _firstValue;
        }
        CardData newCard = CardData(courseName: _selectedCourse!.name, questions: _questions,
            answers: _answers, courseCode: _selectedCourse!.courseCode,
            title: _titleController.text.isNotEmpty ? _titleController.text : null, isFavorite: [_localUser!]);
        BlocProvider.of<CardsCubit>(context)..createCard(newCard);
      } else if(editCard != null ){
        if(_selectedCourse == null){
          _selectedCourse = _firstValue;
        }
        List<String> favorites = [];
        favorites.addAll(editCard!.isFavorite!);
        favorites.add(_localUser!);
        CardData newCard = editCard!.copyWith(
            title: _titleController.text.isNotEmpty ? _titleController.text : null,
            courseCode: _selectedCourse!.courseCode,
            courseName: _selectedCourse!.name,
            questions: _questions,
            answers: _answers,
            isFavorite: favorites
        );
        BlocProvider.of<CardsCubit>(context)..updateCard(newCard);
      }
    }
  }

  void _deleteCard() {
    BlocProvider.of<CardsCubit>(context)..deleteCard(editCard, _localUser);
  }
}

class CardItem extends StatefulWidget {
  ValueChanged<CardContent>? onCardChanged;
  String? question;
  String? answer;
  bool saved;
  final int index;

  CardItem(this.index, this.saved, {this.onCardChanged, this.question, this.answer});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  var _questionController = TextEditingController();
  var _answerController = TextEditingController();
  bool _enabled = true;
  Color _cardColor = Resources.customColors.editCardBackground;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    if(widget.question != null && widget.answer != null){
      _questionController.text = widget.question!;
      _answerController.text = widget.answer!;
      setState(() {
        _enabled = false;
        _cardColor = Resources.customColors.lightGreen;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10,
        color: _cardColor,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !widget.saved && widget.onCardChanged != null ? IconButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        widget.onCardChanged!(
                            CardContent(
                                widget.index,
                                _questionController.text,
                                _answerController.text
                            ));
                        setState(() {
                          widget.saved = true;
                          _enabled = false;
                          _cardColor = Resources.customColors.lightGreen;
                        });
                      }
                    },
                    icon: Icon(Icons.check, size: 30, color: Colors.black),
                  ) : IconButton(
                    onPressed: (){
                      setState(() {
                        widget.saved = false;
                        _enabled = true;
                        _cardColor = Resources.customColors.editCardBackground;
                      });
                    },
                    icon: Icon(Icons.edit, size: 30, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      onPressed: (){
                        widget.onCardChanged!(
                            CardContent(
                                widget.index,
                                _questionController.text,
                                _answerController.text,
                                deleted: true
                            )
                        );
                      },
                      icon: Icon(Icons.delete, size: 30, color: Colors.black),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: TextFormField(
                  controller: _questionController,
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  minLines: 1,
                  maxLines: 3,
                  enabled: _enabled,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.question ?? 'Question',
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    } else return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: TextFormField(
                  controller: _answerController,
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  minLines: 1,
                  maxLines: 3,
                  enabled: _enabled,
                  style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)?.answer ?? 'Answer',
                      hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.of(context)?.empty_field ?? 'Please enter some text';
                    } else return null;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent {
  int index;
  String question;
  String answer;
  bool deleted;

  CardContent(this.index, this.question, this.answer, {this.deleted = false});
}