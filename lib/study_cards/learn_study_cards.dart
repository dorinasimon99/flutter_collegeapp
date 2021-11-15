import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/cards/card_cubit.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
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
  bool? _favorite;
  bool _refresh = false;

  void _setFavorite(bool value){
    if(_favorite == null){
      setState(() {
        _favorite = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_refresh){
      card = ModalRoute.of(context)!.settings.arguments as CardData;
      _setFavorite(card!.isFavorite);
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
                Flexible(
                  child: Text(
                    "${card!.title != null && card!.title!.isNotEmpty ? card!.title! : card!.courseName} ${AppLocalizations.of(context)?.cards ?? 'cards'}" ,
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 30),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      setState(() {
                        _favorite = !_favorite!;
                      });
                      _updateFavorites();
                    },
                    icon: Icon(_favorite! ? Icons.favorite : Icons.favorite_border, size: 40, color: Resources.customColors.cardGreen),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: _navigateToAddCard,
                    icon: Icon(Icons.edit, size: 40),
                  ),
                )
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
                                  child: Text(
                                    card!.questions.elementAt(index),
                                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                                  ),
                                )
                            ),
                            back: Card(
                                color: Resources.customColors.cardGreen,
                                child: Center(
                                  child: Text(
                                    card!.answers.elementAt(index),
                                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
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
    CardData? saveCard = card?.copyWith(isFavorite: _favorite);
    BlocProvider.of<CardsCubit>(context).saveCard(saveCard);
  }
}

