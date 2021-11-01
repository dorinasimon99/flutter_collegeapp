import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';

import 'courses_repository.dart';

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

  void getLocalCourses() async {
    if (state is ListCoursesSuccess == false) {
      emit(LoadingCourses());
    }

    try {
      final courses = await _coursesRepo.getLocalCourses();
      emit(ListCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListCoursesFailure(exception: e));
    }
  }

  void getTeacherCourses(String teacherName) async {
    if (state is ListCoursesSuccess == false) {
      emit(LoadingCourses());
    }
    try {
      final courses = await _coursesRepo.getTeacherCourses(teacherName);
      emit(ListCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListCoursesFailure(exception: e));
    }
  }

  void createCourse(CourseData course) async {
    await _coursesRepo.createCourse(course);
    getCourses();
  }

  void updateCourse(CourseData course) async {
    await _coursesRepo.updateCourse(course);
    getCourses();
  }
}