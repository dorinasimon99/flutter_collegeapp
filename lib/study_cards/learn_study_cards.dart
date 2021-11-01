import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/models/CardData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class LearnStudyCardsPage extends StatefulWidget {

  @override
  _LearnStudyCardsPageState createState() => _LearnStudyCardsPageState();
}

class _LearnStudyCardsPageState extends State<LearnStudyCardsPage> {
  @override
  Widget build(BuildContext context) {
    CardData card = ModalRoute.of(context)!.settings.arguments as CardData;
    return Scaffold(
      appBar: header(context, isMenu: false),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${card.courseName} ${AppLocalizations.of(context)?.cards ?? 'cards'}" ,
              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
            ),
            Flexible(
              child: Center(
                child: SizedBox(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Swiper(
                      itemCount: card.questions.length,
                      itemBuilder: (BuildContext context,int index){
                        return FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            front: Card(
                                color: Color(0xFFC7E5C8),
                                child: Center(
                                  child: Text(
                                    card.questions.elementAt(index),
                                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                                  ),
                                )
                            ),
                            back: Card(
                                color: Color(0xFFC7E5C8),
                                child: Center(
                                  child: Text(
                                    card.answers.elementAt(index),
                                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
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
}

