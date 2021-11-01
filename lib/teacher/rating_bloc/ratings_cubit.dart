import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/teacher/rating_bloc/rating_model.dart';
import 'package:flutter_collegeapp/teacher/rating_bloc/ratings_repository.dart';

abstract class RatingsState {}

class LoadingRatings extends RatingsState {}

class GetRatingsSuccess extends RatingsState {
  final RatingModel rating;

  GetRatingsSuccess({required this.rating});
}

class GetRatingsFailure extends RatingsState {
  final Object exception;

  GetRatingsFailure({required this.exception});
}

class RatingsCubit extends Cubit<RatingsState> {
  final _ratingsRepo = RatingsRepository();

  RatingsCubit() : super(LoadingRatings());

  void getRatings(String teacherName, String courseID) async {
    if (state is GetRatingsSuccess == false) {
      emit(LoadingRatings());
    }

    try {
      final ratings = await _ratingsRepo.getRatings(teacherName, courseID);
      emit(GetRatingsSuccess(rating: ratings));
    } catch (e) {
      emit(GetRatingsFailure(exception: e));
    }
  }

  void createRating(String teacherName, String courseID, double rating) async {
    await _ratingsRepo.createRating(teacherName, courseID, rating);
  }

  void updateRating(String teacherName, String courseID, double rating) async {
    await _ratingsRepo.updateRating(teacherName, courseID, rating);
    getRatings(teacherName, courseID);
  }
}