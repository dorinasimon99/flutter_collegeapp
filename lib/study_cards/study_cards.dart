import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/bloc/cards/card_cubit.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:flutter_collegeapp/models/CardData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../app.dart';

class StudyCardsPage extends StatefulWidget {

  @override
  _StudyCardsPageState createState() => _StudyCardsPageState();
}

class _StudyCardsPageState extends State<StudyCardsPage> {
  bool _favorites = true;
  List<CardData> _favoriteTabCards = <CardData>[];
  List<CardData> _allTabCards = <CardData>[];
  String? _username;

  void _getUsername() async {
    var username = await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME);
    _username = username;
    if(username != null){
      BlocProvider.of<CardsCubit>(context)..getCards(_username);
      BlocProvider.of<CardsCubit>(context)..getFavoriteCards(_username);
    }
  }

  @override
  void initState(){
    super.initState();
    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                bottom: 0,
                child: HomeButton(context))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)?.study_cards ?? 'Study cards',
                  style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'addCard'),
                  child: Text(
                    "+",
                    style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 40),
                  ),
                )
              ],
            ),
            BlocListener<CardsCubit, CardsState>(
              listener: (context, state){
                if(state is CreateCardSuccess){
                  BlocProvider.of<CardsCubit>(context)..getCards(_username);
                  BlocProvider.of<CardsCubit>(context)..getFavoriteCards(_username);
                } else if(state is SaveCardSuccess){
                  BlocProvider.of<CardsCubit>(context)..getFavoriteCards(_username);
                } else if(state is CreateCardFailure){
                  showErrorAlert(state.exception.toString(), context);
                } else if(state is SaveCardFailure){
                  showErrorAlert(state.exception.toString(), context);
                } else if(state is UpdateCardSuccess){
                  BlocProvider.of<CardsCubit>(context)..getCards(_username);
                  BlocProvider.of<CardsCubit>(context)..getFavoriteCards(_username);
                } else if(state is UpdateCardFailure){
                  showErrorAlert(state.exception.toString(), context);
                }
              },
              child: Container(),
            ),
            Expanded(
              child: BlocListener<CardsCubit, CardsState>(
                listener: (context, state) {
                  if(state is ListCardsSuccess){
                    setState(() {
                      _allTabCards = state.cards;
                    });
                  } else if(state is ListFavoriteCardsSuccess){
                    setState(() {
                      _favoriteTabCards = state.cards;
                    });
                  } else if(state is ListCardsFailure){
                    showErrorAlert(state.exception.toString(), context);
                  }
                },
                child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TabBar(
                          indicatorColor: Resources.customColors.cursorGreen,
                          labelColor: Colors.black,
                          labelStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                          tabs: [
                            Tab(text: AppLocalizations.of(context)?.favorites ?? 'Favorites'),
                            Tab(text: AppLocalizations.of(context)?.all ?? 'All'),
                          ],
                        )
                      ],
                    ),
                    automaticallyImplyLeading: false,
                  ),
                  body: TabBarView(
                    children: [
                      StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          itemCount: _favoriteTabCards.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(context, 'learn_cards',
                                      arguments: _favoriteTabCards[index]),
                                  child: Card(
                                      color: Resources.customColors.cardGreen,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                          child: Text(
                                            _favoriteTabCards[index].title != null && _favoriteTabCards[index].title!.isNotEmpty ?
                                            _favoriteTabCards[index].title! : _favoriteTabCards[index].courseName,
                                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                          staggeredTileBuilder: (int index) => StaggeredTile.fit(2)
                      ),
                      StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          itemCount: _allTabCards.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(context, 'learn_cards',
                                      arguments: _allTabCards[index]),
                                  child: Card(
                                      color: Resources.customColors.cardGreen,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                          child: Text(
                                            _allTabCards[index].title != null && _allTabCards[index].title!.isNotEmpty ?
                                            _allTabCards[index].title! : _allTabCards[index].courseName,
                                            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                          staggeredTileBuilder: (int index) => StaggeredTile.fit(2)
                      ),
                    ],
                  )
              )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
