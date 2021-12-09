import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/lessons/lesson_repository.dart';
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

class ListUserLessonsSuccess extends LessonsState {
  final List<LessonData> lessons;

  ListUserLessonsSuccess({required this.lessons});
}

class ListUserLessonsFailure extends LessonsState {
  final Object exception;

  ListUserLessonsFailure({required this.exception});
}

class ListTodayLessonsSuccess extends LessonsState {
  final List<LessonData> lessons;

  ListTodayLessonsSuccess({required this.lessons});
}

class ListTodayLessonsFailure extends LessonsState {
  final Object exception;

  ListTodayLessonsFailure({required this.exception});
}

class ListCourseLessonsSuccess extends LessonsState {
  final List<LessonData> lessons;

  ListCourseLessonsSuccess({required this.lessons});
}

class ListCourseLessonsFailure extends LessonsState {
  final Object exception;

  ListCourseLessonsFailure({required this.exception});
}

class SaveLessonSuccess extends LessonsState {}

class SaveLessonFailure extends LessonsState {
  final Object exception;

  SaveLessonFailure({required this.exception});
}

class CreateLessonSuccess extends LessonsState {
  final LessonData lesson;
  CreateLessonSuccess({required this.lesson});
}

class CreateLessonFailure extends LessonsState {
  final Object exception;

  CreateLessonFailure({required this.exception});
}

class UpdateLessonSuccess extends LessonsState {
  final LessonData lesson;
  UpdateLessonSuccess({required this.lesson});
}

class UpdateLessonFailure extends LessonsState {
  final Object exception;

  UpdateLessonFailure({required this.exception});
}

class GetLessonSuccess extends LessonsState {
  final LessonData lesson;

  GetLessonSuccess({required this.lesson});
}

class GetLessonFailure extends LessonsState {
  final Object exception;

  GetLessonFailure({required this.exception});
}



class LessonsCubit extends Cubit<LessonsState> {
  final _lessonsRepo = LessonsRepository();

  LessonsCubit() : super(LoadingLessons());

  void getLessonByID(String id) async {
    if (state is GetLessonSuccess == false) {
      emit(LoadingLessons());
    }

    try {
      final lesson = await _lessonsRepo.getLessonByID(id);
      emit(GetLessonSuccess(lesson: lesson));
    } catch (e) {
      emit(GetLessonFailure(exception: e));
    }
  }

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

  void getUserLessons(String username, int actualSemester) async {
    if (state is ListUserLessonsSuccess == false) {
      emit(LoadingLessons());
    }

    try {
      final lessons = await _lessonsRepo.getUserLessons(username, actualSemester);
      emit(ListUserLessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(ListUserLessonsFailure(exception: e));
    }
  }

  void getCourseLessons(String? courseCode) async {
    if (state is ListCourseLessonsSuccess == false) {
      emit(LoadingLessons());
    }

    if (courseCode == null) {
      emit(ListCourseLessonsFailure(exception: Exception("CourseCode is null")));
    } else {
      try {
        final lessons = await _lessonsRepo.getCourseLessons(courseCode);
        emit(ListCourseLessonsSuccess(lessons: lessons));
      } catch (e) {
        emit(ListCourseLessonsFailure(exception: e));
      }
    }
  }

  void getTodayLessons(String username, int? actualSemester, String date) async {
    if (state is ListTodayLessonsSuccess == false) {
      emit(LoadingLessons());
    }

    try {
      final lessons = await _lessonsRepo.getTodayLessons(username, actualSemester, date);
      emit(ListTodayLessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(ListTodayLessonsFailure(exception: e));
    }
  }

  void createLesson(LessonData lesson) async {
    try{
      await _lessonsRepo.createLesson(lesson);
      emit(CreateLessonSuccess(lesson: lesson));
    } catch(e){
      emit(CreateLessonFailure(exception: e));
    }
  }

  void updateLesson(LessonData lesson) async {
    try{
      await _lessonsRepo.updateLesson(lesson);
      emit(UpdateLessonSuccess(lesson: lesson));
    } catch(e){
      emit(UpdateLessonFailure(exception: e));
    }
  }
}