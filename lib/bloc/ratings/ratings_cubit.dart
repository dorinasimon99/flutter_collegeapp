import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/teacher/rating_model.dart';
import 'package:flutter_collegeapp/bloc/ratings/ratings_repository.dart';

abstract class RatingsState {}

class LoadingRatings extends RatingsState {}

class GetRatingsSuccess extends RatingsState {
  final RatingModel? rating;

  GetRatingsSuccess({required this.rating});
}

class GetRatingsFailure extends RatingsState {
  final Object exception;

  GetRatingsFailure({required this.exception});
}

class UpdateRatingSuccess extends RatingsState {}

class UpdateRatingFailure extends RatingsState {
  final Object exception;

  UpdateRatingFailure({required this.exception});
}

class RatingsCubit extends Cubit<RatingsState> {
  final _ratingsRepo = RatingsRepository();

  RatingsCubit() : super(LoadingRatings());

  void getRatings(String teacherName, String courseCode) async {
    if (state is GetRatingsSuccess == false) {
      emit(LoadingRatings());
    }

    try {
      final ratings = await _ratingsRepo.getRatings(teacherName, courseCode);
      emit(GetRatingsSuccess(rating: ratings));

    } catch (e) {
      emit(GetRatingsFailure(exception: e));
    }
  }

  void updateRating(String teacherName, String courseCode, double rating) async {
    try{
      await _ratingsRepo.updateRating(teacherName, courseCode, rating);
      emit(UpdateRatingSuccess());
    } catch(e){
      emit(UpdateRatingFailure(exception: e));
    }
  }
}