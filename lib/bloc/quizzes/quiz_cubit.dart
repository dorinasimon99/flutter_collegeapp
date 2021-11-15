import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/quizzes/quiz_repository.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


abstract class QuizzesState {}

class LoadingQuizzes extends QuizzesState {}

class ListQuizzesSuccess extends QuizzesState {
  final List<QuizData> quizzes;

  ListQuizzesSuccess({required this.quizzes});
}

class ListQuizzesFailure extends QuizzesState {
  final Object exception;

  ListQuizzesFailure({required this.exception});
}

class ListAllQuizzesSuccess extends QuizzesState {
  final List<QuizData> quizzes;

  ListAllQuizzesSuccess({required this.quizzes});
}

class ListAllQuizzesFailure extends QuizzesState {
  final Object exception;

  ListAllQuizzesFailure({required this.exception});
}

class CreateQuizSuccess extends QuizzesState {}

class CreateQuizFailure extends QuizzesState {
  final Object exception;

  CreateQuizFailure({required this.exception});
}

class UpdateQuizSuccess extends QuizzesState {}

class UpdateQuizFailure extends QuizzesState {
  final Object exception;

  UpdateQuizFailure({required this.exception});
}

class QuizzesCubit extends Cubit<QuizzesState> {
  final _quizzesRepo = QuizzesRepository();

  QuizzesCubit() : super(LoadingQuizzes());

  void getAllQuizzes() async {
    if (state is ListQuizzesSuccess == false) {
      emit(LoadingQuizzes());
    }

    try {
      final quizzes = await _quizzesRepo.getAllQuizzes();
      emit(ListAllQuizzesSuccess(quizzes: quizzes));
    } catch (e) {
      emit(ListAllQuizzesFailure(exception: e));
    }
  }

  void getQuizzes(String lessonID, String? role) async {
    if (state is ListQuizzesSuccess == false) {
      emit(LoadingQuizzes());
    }

    try {
      final quizzes = await _quizzesRepo.getQuizzes(lessonID, role);
      emit(ListQuizzesSuccess(quizzes: quizzes));
    } catch (e) {
      emit(ListQuizzesFailure(exception: e));
    }
  }

  void createQuiz(QuizData quiz) async {
    try{
      await _quizzesRepo.createQuiz(quiz);
      emit(CreateQuizSuccess());
    } catch(e) {
      emit(CreateQuizFailure(exception: e));
    }
  }

  void updateQuiz(QuizData quiz) async {
    try{
      await _quizzesRepo.updateQuiz(quiz);
      emit(UpdateQuizSuccess());
    } catch(e) {
      emit(UpdateQuizFailure(exception: e));
    }
  }
}