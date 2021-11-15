import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';
import 'package:flutter_collegeapp/teacher/rating_model.dart';


class RatingsRepository {

  Future<RatingModel?> getRatings(String teacherName, String courseCode) async {
    try {
      RatingModel? rating;
      var item = (await Amplify.DataStore.query(UserCourse.classType,
          where: UserCourse.NAME.eq(teacherName).and(UserCourse.COURSECODE.eq(courseCode))))[0];
      if(item.ratingNum != null && item.rating != null){
        rating = RatingModel(ratingNum: item.ratingNum!, rating: item.rating!);
      }

      return rating;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateRating(String teacherName, String courseCode, double rating) async {
    try {
      var userCourse = (await Amplify.DataStore.query(UserCourse.classType,
          where: UserCourse.NAME.eq(teacherName).and(UserCourse.COURSECODE.eq(courseCode))))[0];
      double newRating;
      int newRatingNum;
      if(userCourse != null){
        if(userCourse.rating == null){
          newRating = rating;
          newRatingNum = 1;
        } else {
          newRatingNum = userCourse.ratingNum! + 1;
          newRating = (rating + double.parse(userCourse.rating!))/newRatingNum;
        }
        await Amplify.DataStore.save(userCourse.copyWith(rating: newRating.toString(), ratingNum: newRatingNum));
      }
    } catch (e) {
      throw e;
    }
  }
}