import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/bloc/todos/todos_repository.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

abstract class TodosState {}

class LoadingTodos extends TodosState {}

class CreateTodoSuccess extends TodosState {}

class CreateTodoFailure extends TodosState {
  final Object exception;

  CreateTodoFailure({required this.exception});
}

class UpdateTodoSuccess extends TodosState {}

class UpdateTodoFailure extends TodosState {
  final Object exception;

  UpdateTodoFailure({required this.exception});
}

class ListTodosSuccess extends TodosState {
  final List<TodoData> todos;

  ListTodosSuccess({required this.todos});
}

class ListTodosFailure extends TodosState {
  final Object exception;

  ListTodosFailure({required this.exception});
}

class ListTodosWithDeadlineSuccess extends TodosState {
  final List<TodoData> todos;

  ListTodosWithDeadlineSuccess({required this.todos});
}

class ListTodosWithDeadlineFailure extends TodosState {
  final Object exception;

  ListTodosWithDeadlineFailure({required this.exception});
}

class ListLessonTodosSuccess extends TodosState {
  final List<TodoData> todos;
  final String lessonID;

  ListLessonTodosSuccess({required this.todos, required this.lessonID});
}

class ListLessonTodosFailure extends TodosState {
  final Object exception;

  ListLessonTodosFailure({required this.exception});
}

class TodosCubit extends Cubit<TodosState> {
  final _todosRepo = TodosRepository();

  TodosCubit() : super(LoadingTodos());

  void getTodos(String? owner, String? courseCode) async {
    if (owner == null || courseCode == null) {
      emit(ListTodosFailure(exception: Exception("Owner $owner or coursecode $courseCode is null")));
    } else {
      try {
        final todos = await _todosRepo.getTodos(owner, courseCode);
        emit(ListTodosSuccess(todos: todos));
      } catch (e) {
        emit(ListTodosFailure(exception: e));
      }
    }
  }

  void getLessonTodos(String? owner, String lessonID) async {
    if(owner == null){
      emit(ListLessonTodosFailure(exception: Exception("Owner is null")));
    } else {
      try {
        final todos = await _todosRepo.getLessonTodos(owner, lessonID);
        emit(ListLessonTodosSuccess(todos: todos, lessonID: lessonID));
      } catch (e) {
        emit(ListLessonTodosFailure(exception: e));
      }
    }
  }

  void getTodosWithDeadline(String owner) async {
    if (state is ListTodosWithDeadlineSuccess == false) {
      emit(LoadingTodos());
    }

    try {
      final todos = await _todosRepo.getTodosWithDeadline(owner);
      emit(ListTodosWithDeadlineSuccess(todos: todos));
    } catch (e) {
      emit(ListTodosWithDeadlineFailure(exception: e));
    }
  }

  void createTodo(TodoData todo) async {
    try {
      await _todosRepo.createTodo(todo);
      emit(CreateTodoSuccess());
    } catch(e) {
      emit(CreateTodoFailure(exception: e));
    }
  }

  void updateTodo(TodoData? todo) async {
    if(todo == null){
      emit(UpdateTodoFailure(exception: Exception('Todo is null')));
    } else {
      try {
        await _todosRepo.updateTodo(todo);
        emit(UpdateTodoSuccess());
      } catch(e) {
        emit(UpdateTodoFailure(exception: e));
      }
    }
  }
}