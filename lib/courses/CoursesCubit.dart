import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';

import 'CoursesRepository.dart';

abstract class CoursesState {}

class LoadingCourses extends CoursesState {}

class ListCoursesSuccess extends CoursesState {
  final List<CourseData> courses;

  ListCoursesSuccess({required this.courses});
}

class ListCoursesFailure extends CoursesState {
  final Object exception;

  ListCoursesFailure({required this.exception});
}

class CoursesCubit extends Cubit<CoursesState> {
  final _coursesRepo = CoursesRepository();

  CoursesCubit() : super(LoadingCourses());

  void getCourses() async {
    if (state is ListCoursesSuccess == false) {
      emit(LoadingCourses());
    }

    try {
      final courses = await _coursesRepo.getCourses();
      emit(ListCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListCoursesFailure(exception: e));
    }
  }

  void getTodayCoursesFromAPI(String day) async {
    if (state is ListCoursesSuccess == false) {
      emit(LoadingCourses());
    }
    try {
      final courses = await _coursesRepo.getTodayCoursesFromAPI(day);
      emit(ListCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListCoursesFailure(exception: e));
    }
  }

  void createCourse(String name, String code, int credits, String time) async {
    await _coursesRepo.createCourse(name, code, credits, time);
    getCourses();
  }

  void updateCourse(CourseData course) async {
    await _coursesRepo.updateCourse(course);
    getCourses();
  }
}