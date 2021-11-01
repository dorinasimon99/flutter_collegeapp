import 'package:flutter_collegeapp/local_database/database_models/database_course.dart';
import 'package:flutter_collegeapp/local_database/database_models/database_lesson.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();

  static Database? _database;

  LocalDatabase._init();

  static final String coursesTable = "coursesTable";
  static final String lessonsTable = "lessonsTable";
  static final String cardsTable = "cardsTable";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('college_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''CREATE TABLE $coursesTable (
    ${DatabaseCourseFields.id} INTEGER PRIMARY KEY, 
    ${DatabaseCourseFields.cloudId} TEXT NOT NULL, 
    ${DatabaseCourseFields.courseCode} TEXT NOT NULL, 
    ${DatabaseCourseFields.name} TEXT NOT NULL, 
    ${DatabaseCourseFields.credits} INTEGER NOT NULL, 
    ${DatabaseCourseFields.time} TEXT NOT NULL, 
    ${DatabaseCourseFields.teachers} TEXT)''');
    await db.execute('''CREATE TABLE lessonsTable(id INTEGER PRIMARY KEY, cloudId TEXT NOT NULL, title TEXT NOT NULL, date TEXT NOT NULL, time TEXT NOT NULL, ownerID TEXT NOT NULL, courseCode TEXT NOT NULL, description TEXT)''');
    await db.execute('''CREATE TABLE cardsTable(id INTEGER PRIMARY KEY, cloudId TEXT NOT NULL, courseCode TEXT NOT NULL, courseName TEXT NOT NULL, questions TEXT NOT NULL, answers TEXT NOT NULL)''');
  }

  Future<CourseData> createCourse(CourseData course) async {
    final db = await instance.database;
    var teachers = "";
    if(course.teachers != null){
      teachers = concatenate(course.teachers!);
    }
    var saveCourse = DatabaseCourse(cloudId: course.id, courseCode: course.courseCode, name: course.name, credits: course.credits, time: course.time, teachers: teachers.isNotEmpty ? teachers : null);
    await db.insert(coursesTable, saveCourse.toJson());
    return course;
  }

  Future<CourseData> readCourse(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      coursesTable,
      columns: ["id", "cloudId", "courseCode", "name", "credits", "time", "teachers"],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      var course = DatabaseCourse.fromJson(maps.first);
      var teachers = course.teachers == null ? null : course.teachers!.split(",");
      return CourseData(courseCode: course.courseCode, name: course.name, credits: course.credits, time: course.time, teachers: teachers);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<CourseData>> readTodayCourses(String day) async {
    final db = await instance.database;

    final maps = await db.query(
      coursesTable,
      columns: ["id", "cloudId", "courseCode", "name", "credits", "time", "teachers"],
      where: 'time LIKE ?%',
      whereArgs: [day],
    );

    if (maps.isNotEmpty) {
      var todayCourses = <CourseData>[];
      for(var item in maps){
        var course = DatabaseCourse.fromJson(item);
        var teachers = course.teachers == null ? null : course.teachers!.split(",");
        todayCourses.add(CourseData(courseCode: course.courseCode, name: course.name, credits: course.credits, time: course.time, teachers: teachers));
      }
      return todayCourses;
    } else {
      throw Exception('Day $day not found');
    }
  }

  Future<List<CourseData>> readAllCourses() async {
    final db = await instance.database;

    final result = await db.query(coursesTable);

    var courses = <CourseData>[];

    for(var course in result.map((json) => DatabaseCourse.fromJson(json)).toList()){
      var teachers = course.teachers == null ? null : course.teachers!.split(",");
      courses.add(CourseData(courseCode: course.courseCode, name: course.name, credits: course.credits, time: course.time, teachers: teachers));
    }

    return courses;
  }

  Future<int> updateCourse(CourseData course) async {
    final db = await instance.database;

    var teachers = "";
    if(course.teachers != null){
      teachers = concatenate(course.teachers!);
    }
    var updateCourse = DatabaseCourse(cloudId: course.id, courseCode: course.courseCode, name: course.name, credits: course.credits, time: course.time, teachers: teachers.isNotEmpty ? teachers : null);

    return db.update(
      coursesTable,
      updateCourse.toJson(),
      where: 'cloudId = ?',
      whereArgs: [course.id],
    );
  }

  Future<int> deleteCourse(int id) async {
    final db = await instance.database;

    return await db.delete(
      coursesTable,
      where: 'cloudId = ?',
      whereArgs: [id],
    );
  }

  Future<DatabaseLesson> createLesson(DatabaseLesson lesson) async {
    final db = await instance.database;
    final id = await db.insert(lessonsTable, lesson.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return lesson.copy(id: id);
  }

  Future<DatabaseLesson> readLesson(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      lessonsTable,
      columns: ["id", "cloudId", "title", "date", "time", "ownerId", "courseCode", "description"],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DatabaseLesson.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DatabaseLesson>> readAllLessons() async {
    final db = await instance.database;

    final result = await db.query(lessonsTable);

    return result.map((json) => DatabaseLesson.fromJson(json)).toList();
  }

  Future<int> updateLesson(DatabaseLesson lesson) async {
    final db = await instance.database;

    return db.update(
      lessonsTable,
      lesson.toJson(),
      where: 'id = ?',
      whereArgs: [lesson.id],
    );
  }

  Future<int> deleteLesson(int id) async {
    final db = await instance.database;

    return await db.delete(
      lessonsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  String concatenate(List<String> list) {
    var concatenated = "";
    for(var string in list){
      concatenated = "$concatenated, $string";
    }
    return concatenated;
  }
}