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

class CreateCardSuccess extends CardsState {
  final CardData card;
  CreateCardSuccess({required this.card});
}

class CreateCardFailure extends CardsState {
  final Object exception;

  CreateCardFailure({required this.exception});
}

class UpdateCardSuccess extends CardsState {
  final CardData card;
  UpdateCardSuccess({required this.card});
}

class UpdateCardFailure extends CardsState {
  final Object exception;

  UpdateCardFailure({required this.exception});
}

class SaveCardSuccess extends CardsState {
  SaveCardSuccess();
}

class SaveCardFailure extends CardsState {
  final Object exception;

  SaveCardFailure({required this.exception});
}

class ListFavoriteCardsSuccess extends CardsState {
  final List<CardData> cards;

  ListFavoriteCardsSuccess({required this.cards});
}

class CardsCubit extends Cubit<CardsState> {
  final _cardsRepo = CardsRepository();

  CardsCubit() : super(LoadingCards());

  void getCards(String? username) async {
    if(username == null){
      emit(ListCardsFailure(exception: Exception("Username is null")));
    } else {
      try {
        final cards = await _cardsRepo.getCards(username);
        emit(ListCardsSuccess(cards: cards));
      } catch (e) {
        emit(ListCardsFailure(exception: e));
      }
    }
  }

  void getFavoriteCards(String? username) async {
    if(username == null){
      emit(ListCardsFailure(exception: Exception("Username is null")));
    } else {
      try {
        final cards = await _cardsRepo.getFavoriteCards(username);
        emit(ListFavoriteCardsSuccess(cards: cards));
      } catch (e) {
        emit(ListCardsFailure(exception: e));
      }
    }
  }

  void saveCard(CardData? card) async {
    if(card == null){
      emit(SaveCardFailure(exception: Exception("Card is null")));
    } else {
      try{
        await _cardsRepo.saveCard(card);
        emit(SaveCardSuccess());
      } catch (e){
        emit(SaveCardFailure(exception: e));
      }
    }
  }

  void createCard(CardData card) async {
    try{
      await _cardsRepo.createCard(card);
      emit(CreateCardSuccess(card: card));
    } catch (e){
      emit(CreateCardFailure(exception: e));
    }
  }

  void updateCard(CardData? card) async {
    if(card == null){
      emit(UpdateCardFailure(exception: Exception("Card is null")));
    } else {
      try{
        await _cardsRepo.updateCard(card);
        emit(UpdateCardSuccess(card: card));
      } catch (e){
        emit(UpdateCardFailure(exception: e));
      }
    }
  }
}