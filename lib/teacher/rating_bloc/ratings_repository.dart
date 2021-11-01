import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_collegeapp/teacher/rating_bloc/rating_model.dart';


class RatingsRepository {

  //TODO courseName-t törölni
  Future<RatingModel> getRatings(String teacherName, String courseID) async {
    try {
      String graphQLDocument = '''query ListCourses {
        listCourseDatas {
          items {
            id
            name
            courseCode
            time
            credits
          }
        }
      }''';

      /*var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      var list = ListCoursesData.fromJson(jsonDecode(response.data));
      var items = list.list.items;*/

      return RatingModel(ratingNum: 545, rating: 3.5);
    } catch (e) {
      throw e;
    }
  }


  Future<void> createRating(String teacherName, String courseID, double rating) async {
    try {
      String graphQLDocument = '''mutation CreateCourseData {
        
      }''';

      print("Rating created");
      //Amplify.API.mutate(request: GraphQLRequest<String>(document: graphQLDocument));

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateRating(String teacherName, String courseID, double rating) async {
    //final updatedCard = card.copyWith();
    try {
      //TODO
    } catch (e) {
      throw e;
    }
  }
}