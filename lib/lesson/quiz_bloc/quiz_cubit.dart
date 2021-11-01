import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/lesson/quiz_bloc/quiz_repository.dart';
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

class QuizzesCubit extends Cubit<QuizzesState> {
  final _quizzesRepo = QuizzesRepository();

  QuizzesCubit() : super(LoadingQuizzes());

  void getQuizzes(String lessonID) async {
    if (state is ListQuizzesSuccess == false) {
      emit(LoadingQuizzes());
    }

    try {
      final quizzes = await _quizzesRepo.getQuizzes(lessonID);
      emit(ListQuizzesSuccess(quizzes: quizzes));
    } catch (e) {
      emit(ListQuizzesFailure(exception: e));
    }
  }

  void createQuiz(QuizData quiz) async {
    await _quizzesRepo.createQuiz(quiz);
  }

  void updateQuiz(QuizData quiz) async {
    await _quizzesRepo.updateQuiz(quiz);
    getQuizzes(quiz.lessonID);
  }
}