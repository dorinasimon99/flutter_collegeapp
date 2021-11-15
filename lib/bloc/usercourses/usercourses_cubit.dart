import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/usercourses/usercourses_repository.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

abstract class UserCoursesState {}

class LoadingUserCourses extends UserCoursesState {}

class ListUserCoursesSuccess extends UserCoursesState {
  final List<UserCourse> userCourses;

  ListUserCoursesSuccess({required this.userCourses});
}

class ListUserCoursesFailure extends UserCoursesState {
  final Object exception;

  ListUserCoursesFailure({required this.exception});
}

class ListActualSemesterUserCoursesSuccess extends UserCoursesState {
  final List<UserCourse> userCourses;

  ListActualSemesterUserCoursesSuccess({required this.userCourses});
}

class ListActualSemesterUserCoursesFailure extends UserCoursesState {
  final Object exception;

  ListActualSemesterUserCoursesFailure({required this.exception});
}

class GetUserCourseSuccess extends UserCoursesState {
  final UserCourse userCourse;

  GetUserCourseSuccess({required this.userCourse});
}

class GetUserCourseFailure extends UserCoursesState {
  final Object exception;

  GetUserCourseFailure({required this.exception});
}

class UserCoursesCubit extends Cubit<UserCoursesState> {
  final _userCoursesRepo = UserCoursesRepository();

  UserCoursesCubit() : super(LoadingUserCourses());

  void getUserCourses() async {
    if (state is ListUserCoursesSuccess == false) {
      emit(LoadingUserCourses());
    }

    try {
      final userCourses = await _userCoursesRepo.getUserCourses();
      emit(ListUserCoursesSuccess(userCourses: userCourses));
    } catch (e) {
      emit(ListUserCoursesFailure(exception: e));
    }
  }

  void getUserCoursesByUsername(String username) async {
    try {
      final userCourse = await _userCoursesRepo.getUserCoursesByUsername(username);
      emit(ListUserCoursesSuccess(userCourses: userCourse));
    } catch (e) {
      emit(ListUserCoursesFailure(exception: e));
    }
  }

  void getUserCourse(String name, String courseCode) async {
    try {
      final userCourse = await _userCoursesRepo.getUserCourseByNameAndCourseCode(name, courseCode);
      if(userCourse != null){
        emit(GetUserCourseSuccess(userCourse: userCourse));
      }
    } catch (e) {
      emit(GetUserCourseFailure(exception: e));
    }
  }

  void getActualSemesterUserCourses(String username, int actualSemester) async {
    try {
      final userCourse = await _userCoursesRepo.getActualSemesterUserCourses(username, actualSemester);
      emit(ListActualSemesterUserCoursesSuccess(userCourses: userCourse));
    } catch (e) {
      emit(ListActualSemesterUserCoursesFailure(exception: e));
    }
  }

  void createUserCourse(UserCourse userCourse) async {
    await _userCoursesRepo.createUserCourse(userCourse);
  }

  void updateUserCourse(UserCourse userCourse) async {
    await _userCoursesRepo.updateUserCourse(userCourse);
  }

}