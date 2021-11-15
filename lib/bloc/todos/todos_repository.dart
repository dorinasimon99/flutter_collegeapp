import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class TodosRepository {

  Future<List<TodoData>> getTodos(String owner, String courseCode) async {
    try {
      var items = await Amplify.DataStore.query(TodoData.classType,
      where: TodoData.OWNER.eq(owner).and(TodoData.COURSECODE.eq(courseCode).and(TodoData.DONE.eq('false').or(TodoData.DONE.eq(false)))));
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<TodoData>> getLessonTodos(String owner, String lessonID) async {
    try {
      var items = await Amplify.DataStore.query(TodoData.classType,
          where: TodoData.OWNER.eq(owner).and(TodoData.LESSONID.eq(lessonID).and(TodoData.DONE.eq('false').or(TodoData.DONE.eq(false)))));
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<TodoData>> getTodosWithDeadline(String owner) async {
    try {
      var items = await Amplify.DataStore.query(TodoData.classType,
          where: TodoData.OWNER.eq(owner).and(TodoData.DEADLINE.ne(null)));

      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createTodo(TodoData todo) async {
    try{
      await Amplify.DataStore.save(todo);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTodo(TodoData todo) async {
    try{
      await Amplify.DataStore.save(todo);
    } catch (e) {
      throw e;
    }
  }
}