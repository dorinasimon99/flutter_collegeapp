import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/study_cards/card_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../app.dart';

class StudyCardsPage extends StatefulWidget {

  @override
  _StudyCardsPageState createState() => _StudyCardsPageState();
}

class _StudyCardsPageState extends State<StudyCardsPage> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CardsCubit>(context)..getCards();
    return Scaffold(
      appBar: header(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)?.study_cards ?? 'Study cards',
                  style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                ),
                TextButton(
                  onPressed: (){},
                  child: Text(
                    "+",
                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
                  ),
                )
              ],
            ),
            Expanded(
              child: BlocBuilder<CardsCubit, CardsState>(
                  builder: (context, state) {
                    if (state is ListCardsSuccess) {
                      return StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          itemCount: state.cards.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(context, 'learn_cards', arguments: state.cards[index]),
                                  child: Card(
                                      color: Color(0xFFC7E5C8),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                          child: Text(
                                            '${state.cards[index].courseName}',
                                            style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                          staggeredTileBuilder: (int index) => StaggeredTile.fit(2)
                      );
                    } else if (state is ListCardsFailure) {
                      return Center(child: Text(state.exception.toString()));
                    } else {
                      return LoadingView();
                    }
                  },
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: homeButton(context),
            )
          ],
        ),
      ),
    );
  }
}
