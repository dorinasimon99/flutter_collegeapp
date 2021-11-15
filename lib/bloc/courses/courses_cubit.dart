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

class ListUsersCoursesSuccess extends CoursesState {
  final List<CourseData> courses;

  ListUsersCoursesSuccess({required this.courses});
}

class ListUsersCoursesFailure extends CoursesState {
  final Object exception;

  ListUsersCoursesFailure({required this.exception});
}

class ListTeachersCoursesSuccess extends CoursesState {
  final List<CourseData> courses;

  ListTeachersCoursesSuccess({required this.courses});
}

class ListTeachersCoursesFailure extends CoursesState {
  final Object exception;

  ListTeachersCoursesFailure({required this.exception});
}

class ListActualSemesterCoursesSuccess extends CoursesState {
  final List<CourseData> courses;

  ListActualSemesterCoursesSuccess({required this.courses});
}

class ListActualSemesterCoursesFailure extends CoursesState {
  final Object exception;

  ListActualSemesterCoursesFailure({required this.exception});
}

class CreateCourseSuccess extends CoursesState {}

class CreateCourseFailure extends CoursesState {
  final Object exception;

  CreateCourseFailure({required this.exception});
}

class UpdateCourseSuccess extends CoursesState {}

class UpdateCourseFailure extends CoursesState {
  final Object exception;

  UpdateCourseFailure({required this.exception});
}

class DeleteCourseSuccess extends CoursesState {}

class DeleteCourseFailure extends CoursesState {
  final Object exception;

  DeleteCourseFailure({required this.exception});
}

class CoursesCubit extends Cubit<CoursesState> {
  final _coursesRepo = CoursesRepository();

  CoursesCubit() : super(LoadingCourses());

  void getCourses() async {

    try {
      final courses = await _coursesRepo.getCourses();
      emit(ListCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListCoursesFailure(exception: e));
    }
  }

  void getUserCourses(String username) async {
    try {
      final courses = await _coursesRepo.getUserCourses(username);
      emit(ListUsersCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListUsersCoursesFailure(exception: e));
    }
  }

  void getActualSemesterCourses(String name, int actualSemester) async {
    try {
      final courses = await _coursesRepo.getActualSemesterCourses(name, actualSemester);
      emit(ListActualSemesterCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListActualSemesterCoursesFailure(exception: e));
    }
  }

  void getTeacherCourses(String teacherName) async {
    try {
      final courses = await _coursesRepo.getTeacherCourses(teacherName);
      emit(ListTeachersCoursesSuccess(courses: courses));
    } catch (e) {
      emit(ListTeachersCoursesFailure(exception: e));
    }
  }

  void createCourse(String username, String name, int semester, CourseData course) async {
    try{
      await _coursesRepo.createCourse(username, name, semester, course);
      emit(CreateCourseSuccess());
    } catch (e){
      emit(CreateCourseFailure(exception: e));
    }
  }

  void updateCourse(String username, int semester, String name, String oldCourseCode, CourseData course, {bool? visible, int? grade}) async {
    try{
      await _coursesRepo.updateCourse(username, semester, name, oldCourseCode, course, visible: visible, grade: grade);
      emit(UpdateCourseSuccess());
    } catch (e){
      emit(UpdateCourseFailure(exception: e));
    }
  }

  void deleteCourse(String name, CourseData course) async {
    try{
      await _coursesRepo.deleteCourse(name, course);
      emit(DeleteCourseSuccess());
    } catch (e){
      emit(DeleteCourseFailure(exception: e));
    }
  }
}