import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_repository.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class CardsRepository {

  Future<List<CardData>> getFavoriteCards(String username) async {
    try {
      var userCourses = await UserCoursesRepository().getUserCoursesByUsername(username);
      var cards = await Amplify.DataStore.query(CardData.classType, where: CardData.ISFAVORITE.eq('true').or(CardData.ISFAVORITE.eq(true)));
      var items = <CardData>[];
      for(var item in cards){
        if(userCourses.any((element) => element.courseCode == item.courseCode)){
          items.add(item);
        }
      }

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CardData>> getCards(String username) async {
    try {
      var userCourses = await UserCoursesRepository().getUserCoursesByUsername(username);
      var cards = await Amplify.DataStore.query(CardData.classType);
      var items = <CardData>[];
      for(var item in cards){
        if(userCourses.any((element) => element.courseCode == item.courseCode)){
          items.add(item);
        }
      }
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveCard(CardData card) async{
    try {
      await Amplify.DataStore.save(card);
    } catch (e) {
      throw e;
    }
  }

  Future<void> createCard(CardData card) async {
    try {
      await Amplify.DataStore.save(card);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCard(CardData card) async {
    try {
      await Amplify.DataStore.save(card);
    } catch (e) {
      throw e;
    }
  }
}