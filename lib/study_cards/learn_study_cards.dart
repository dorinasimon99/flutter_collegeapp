import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/cards/card_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CardData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class LearnStudyCardsPage extends StatefulWidget {

  @override
  _LearnStudyCardsPageState createState() => _LearnStudyCardsPageState();
}

class _LearnStudyCardsPageState extends State<LearnStudyCardsPage> {
  CardData? card;
  bool _favorite = false;
  bool _refresh = false;
  String? _userName;

  void _getUser() async {
    var userName = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    setState(() {
      _userName = userName;
    });
  }

  void _setFavorite(CardData cardData){
    if(cardData.isFavorite?.contains(_userName) == true){
      setState(() {
        _favorite = true;
      });
    } else {
      setState(() {
        _favorite = false;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    if(!_refresh){
      card = ModalRoute.of(context)?.settings.arguments as CardData;
      _setFavorite(card!);
    }
    return Scaffold(
      appBar: Header(context, isMenu: false),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${card?.title != null && card?.title?.isNotEmpty == true ? card?.title ?? '' : card?.courseName} ${AppLocalizations.of(context)?.cards ?? 'cards'}" ,
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                  ),
                ),
                BlocListener<CardsCubit, CardsState>(
                  listener: (context, state) {
                    if(state is UpdateCardSuccess){
                      setState(() {
                        _refresh = true;
                        card = state.card;
                      });
                    } else if(state is UpdateCardFailure){
                      showErrorAlert(state.exception.toString(), context);
                    } else if(state is DeleteCardSuccess){
                      Navigator.pop(context);
                    } else if(state is DeleteCardFailure){
                      showErrorAlert(state.exception.toString(), context);
                    }
                  },
                  child: Container(),
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      _favorite = !_favorite;
                      _refresh = true;
                    });
                    _updateFavorites();
                  },
                  icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border, size: 40, color: Resources.customColors.cardGreen),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: _navigateToAddCard,
                    icon: Icon(Icons.edit, size: 40),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Center(
                child: SizedBox(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Swiper(
                      itemCount: card!.questions.length,
                      itemBuilder: (BuildContext context,int index){
                        return FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            front: Card(
                                color: Resources.customColors.cardGreen,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SingleChildScrollView(
                                      child: Text(
                                          card!.questions.elementAt(index),
                                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            back: Card(
                                color: Resources.customColors.cardGreen,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SingleChildScrollView(
                                      child: Text(
                                          card!.answers.elementAt(index),
                                          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          );
                      },
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddCard() async{
    var result = await Navigator.pushNamed(context, 'addCard', arguments: card) as CardData?;
    if(result != null){
      setState(() {
        _refresh = true;
        card = result;
      });
    }
  }

  void _updateFavorites() async {
    if(card != null){
      List<String> favorites = [];
      favorites.addAll(card!.isFavorite!);
      if(_favorite){
        if(!favorites.contains(_userName)){
          favorites.add(_userName!);
        }
      } else {
        favorites.remove(_userName);
      }
      CardData saveCard = CardData(
          id: card?.id,
          title: card?.title,
          questions: card!.questions,
          answers: card!.answers,
          courseCode: card!.courseCode,
          courseName: card!.courseName,
          isFavorite: favorites
      );
      BlocProvider.of<CardsCubit>(context).updateCard(saveCard);
    }
  }
}

