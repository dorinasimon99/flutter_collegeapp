import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/teacher_model.dart';
import 'package:flutter_collegeapp/courses/teachers/teachers_repository.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';

abstract class TeachersState {}

class LoadingTeachers extends TeachersState {}

class ListTeachersSuccess extends TeachersState {
  final List<TeacherModel> teachers;

  ListTeachersSuccess({required this.teachers});
}

class ListTeachersFailure extends TeachersState {
  final Object exception;

  ListTeachersFailure({required this.exception});
}

class TeachersCubit extends Cubit<TeachersState> {
  final _teachersRepo = TeachersRepository();

  TeachersCubit() : super(LoadingTeachers());

  void getCourseTeachers(String courseID) async {
    if (state is ListTeachersSuccess == false) {
      emit(LoadingTeachers());
    }

    try {
      final teachers = await _teachersRepo.getCourseTeachers(courseID);
      emit(ListTeachersSuccess(teachers: teachers));
    } catch (e) {
      emit(ListTeachersFailure(exception: e));
    }
  }
}