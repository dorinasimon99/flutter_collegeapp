import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/courses/todos/todos_repository.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

abstract class TodosState {}

class LoadingTodos extends TodosState {}

class CreateTodoSuccess extends TodosState {}

class CreateTodoFailure extends TodosState {
  final Object exception;

  CreateTodoFailure({required this.exception});
}

class ListTodosSuccess extends TodosState {
  final List<TodoData> todos;

  ListTodosSuccess({required this.todos});
}

class ListTodosFailure extends TodosState {
  final Object exception;

  ListTodosFailure({required this.exception});
}

class TodosCubit extends Cubit<TodosState> {
  final _todosRepo = TodosRepository();

  TodosCubit() : super(LoadingTodos());

  void getTodos(String courseID) async {
    if (state is ListTodosSuccess == false) {
      emit(LoadingTodos());
    }

    try {
      final todos = await _todosRepo.getTodos(courseID);
      emit(ListTodosSuccess(todos: todos));
    } catch (e) {
      emit(ListTodosFailure(exception: e));
    }
  }

  void getTodosWithDeadline() async {
    if (state is ListTodosSuccess == false) {
      emit(LoadingTodos());
    }

    try {
      final todos = await _todosRepo.getTodosWithDeadline();
      emit(ListTodosSuccess(todos: todos));
    } catch (e) {
      emit(ListTodosFailure(exception: e));
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
}