import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

import 'card_repository.dart';


abstract class CardsState {}

class LoadingCards extends CardsState {}

class ListCardsSuccess extends CardsState {
  final List<CardData> cards;

  ListCardsSuccess({required this.cards});
}

class ListCardsFailure extends CardsState {
  final Object exception;

  ListCardsFailure({required this.exception});
}

class CardsCubit extends Cubit<CardsState> {
  final _cardsRepo = CardsRepository();

  CardsCubit() : super(LoadingCards());

  void getCards() async {
    if (state is ListCardsSuccess == false) {
      emit(LoadingCards());
    }

    try {
      final cards = await _cardsRepo.getCards();
      emit(ListCardsSuccess(cards: cards));
    } catch (e) {
      emit(ListCardsFailure(exception: e));
    }
  }

  void createCard(CardData card) async {
    await _cardsRepo.createCard(card);
  }

  void updateCard(CardData card) async {
    await _cardsRepo.updateCard(card);
    getCards();
  }
}