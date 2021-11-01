import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/lesson/lesson_repository.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


abstract class LessonsState {}

class LoadingLessons extends LessonsState {}

class ListLessonsSuccess extends LessonsState {
  final List<LessonData> lessons;

  ListLessonsSuccess({required this.lessons});
}

class ListLessonsFailure extends LessonsState {
  final Object exception;

  ListLessonsFailure({required this.exception});
}

class LessonsCubit extends Cubit<LessonsState> {
  final _lessonsRepo = LessonsRepository();

  LessonsCubit() : super(LoadingLessons());

  void getLessons() async {
    if (state is ListLessonsSuccess == false) {
      emit(LoadingLessons());
    }

    try {
      final lessons = await _lessonsRepo.getLessons();
      emit(ListLessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(ListLessonsFailure(exception: e));
    }
  }

  void getTodayLessons(String date) async {
    if (state is ListLessonsSuccess == false) {
      emit(LoadingLessons());
    }

    try {
      final lessons = await _lessonsRepo.getTodayLessons(date);
      emit(ListLessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(ListLessonsFailure(exception: e));
    }
  }

  void createLesson(LessonData lesson) async {
    await _lessonsRepo.createLesson(lesson);
  }

  void updateLesson(LessonData lesson) async {
    await _lessonsRepo.updateLesson(lesson);
    getLessons();
  }
}