import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/teacher/teacher_model.dart';
import 'package:flutter_collegeapp/bloc/teachers/teachers_repository.dart';
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

  void getCourseTeachers(String? courseCode) async {
    if (courseCode == null) {
      emit(ListTeachersFailure(exception: Exception("CourseCode is null")));
    } else {
      try {
        final teachers = await _teachersRepo.getCourseTeachers(courseCode);
        emit(ListTeachersSuccess(teachers: teachers));
      } catch (e) {
        emit(ListTeachersFailure(exception: e));
      }
    }
  }
}