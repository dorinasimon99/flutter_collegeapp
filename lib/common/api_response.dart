import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';

class ListCoursesData {
  CourseList list;

  ListCoursesData(this.list);

  factory ListCoursesData.fromJson(dynamic json){
    var objJson = json['listCourseDatas'];
    return ListCoursesData(CourseList.fromJson(objJson));
  }
}

class CourseList {
  List<CourseData> items;

  CourseList(this.items);

  factory CourseList.fromJson(dynamic json){
    List<CourseData> _courses = [];
    if(json != []){
      var coursesObjJson = json['items'] as List;
      _courses = coursesObjJson.map((coursesJson) => CourseData.fromJson(coursesJson)).toList();
    }

    return CourseList(
        _courses
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class CreateCourseData {
  CourseData course;

  CreateCourseData(this.course);

  factory CreateCourseData.fromJson(dynamic json){
    var objJson = json['createCourseData'];
    return CreateCourseData(CourseData.fromJson(objJson));
  }
}

class ListUserCoursesData {
  UserCourseList list;

  ListUserCoursesData(this.list);

  factory ListUserCoursesData.fromJson(dynamic json){
    var objJson = json['listUserCourses'];
    return ListUserCoursesData(UserCourseList.fromJson(objJson));
  }
}

class UserCourseList {
  List<UserCourse> items;

  UserCourseList(this.items);

  factory UserCourseList.fromJson(dynamic json){
    List<UserCourse> _userCourses = [];
    if(json != []){
      var userCoursesObjJson = json['items'] as List;
      _userCourses = userCoursesObjJson.map((userCoursesJson) => UserCourse.fromJson(userCoursesJson)).toList();
    }

    return UserCourseList(
        _userCourses
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class ListTodoData {
  TodoList list;

  ListTodoData(this.list);

  factory ListTodoData.fromJson(dynamic json){
    var objJson = json['listTodoDatas'];
    return ListTodoData(TodoList.fromJson(objJson));
  }
}

class TodoList {
  List<TodoData> items;

  TodoList(this.items);

  factory TodoList.fromJson(dynamic json){
    List<TodoData> _todos = [];
    if(json != []){
      var todosObjJson = json['items'] as List;
      _todos = todosObjJson.map((todosJson) => TodoData.fromJson(todosJson)).toList();
    }

    return TodoList(
        _todos
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class ListLessonData {
  LessonList list;

  ListLessonData(this.list);

  factory ListLessonData.fromJson(dynamic json){
    var objJson = json['listLessonDatas'];
    return ListLessonData(LessonList.fromJson(objJson));
  }
}

class LessonList {
  List<LessonData> items;

  LessonList(this.items);

  factory LessonList.fromJson(dynamic json){
    List<LessonData> _lessons = [];
    if(json != []){
      var lessonsObjJson = json['items'] as List;
      _lessons = lessonsObjJson.map((lessonsJson) => LessonData.fromJson(lessonsJson)).toList();
    }

    return LessonList(
        _lessons
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class ListQuizData {
  QuizList list;

  ListQuizData(this.list);

  factory ListQuizData.fromJson(dynamic json){
    var objJson = json['listQuizDatas'];
    return ListQuizData(QuizList.fromJson(objJson));
  }
}

class QuizList {
  List<QuizData> items;

  QuizList(this.items);

  factory QuizList.fromJson(dynamic json){
    List<QuizData> _quizzes = [];
    if(json != []){
      var quizzesObjJson = json['items'] as List;
      _quizzes = quizzesObjJson.map((quizzesJson) => QuizData.fromJson(quizzesJson)).toList();
    }

    return QuizList(
        _quizzes
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class ListCardData {
  CardList list;

  ListCardData(this.list);

  factory ListCardData.fromJson(dynamic json){
    var objJson = json['listCardDatas'];
    return ListCardData(CardList.fromJson(objJson));
  }
}

class CardList {
  List<CardData> items;

  CardList(this.items);

  factory CardList.fromJson(dynamic json){
    List<CardData> _cards = [];
    if(json != []){
      var cardsObjJson = json['items'] as List;
      _cards = cardsObjJson.map((cardsJson) => CardData.fromJson(cardsJson)).toList();
    }

    return CardList(
        _cards
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class ListCommentData {
  CommentList list;

  ListCommentData(this.list);

  factory ListCommentData.fromJson(dynamic json){
    var objJson = json['listCommentDatas'];
    return ListCommentData(CommentList.fromJson(objJson));
  }
}

class CommentList {
  List<CommentData> items;

  CommentList(this.items);

  factory CommentList.fromJson(dynamic json){
    List<CommentData> _comments = [];
    if(json != []){
      var commentsObjJson = json['items'] as List;
      _comments = commentsObjJson.map((commentJson) => CommentData.fromJson(commentJson)).toList();
    }

    return CommentList(
        _comments
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}

class ListUserData {
  UserList list;

  ListUserData(this.list);

  factory ListUserData.fromJson(dynamic json){
    var objJson = json['listUserDatas'];
    return ListUserData(UserList.fromJson(objJson));
  }
}

class UserList {
  List<UserData> items;

  UserList(this.items);

  factory UserList.fromJson(dynamic json){
    List<UserData> _users = [];
    if(json != []){
      var usersObjJson = json['items'] as List;
      _users = usersObjJson.map((userJson) => UserData.fromJson(userJson)).toList();
    }

    return UserList(
        _users
    );
  }

  @override
  String toString() {
    return '[ ${this.items} ]';
  }
}