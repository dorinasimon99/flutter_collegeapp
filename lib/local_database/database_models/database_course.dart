class DatabaseCourseFields {
  static final List<String> values = [id, cloudId, courseCode, name, credits, time, teachers];

  static final String id = 'id';
  static final String cloudId = 'cloudId';
  static final String courseCode = 'courseCode';
  static final String name = 'name';
  static final String credits = 'credits';
  static final String time = 'time';
  static final String teachers = 'teachers';
}

class DatabaseCourse{
  final int? id;
  final String cloudId;
  final String courseCode;
  final String name;
  final int credits;
  final String time;
  final String? teachers;

  const DatabaseCourse({
    this.id,
    required this.cloudId,
    required this.courseCode,
    required this.name,
    required this.credits,
    required this.time,
    this.teachers
  });

  DatabaseCourse copy({
    int? id,
    String? cloudId,
    String? courseCode,
    String? name,
    int? credits,
    String? time,
    String? teachers
  }) =>
      DatabaseCourse(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        courseCode: courseCode ?? this.courseCode,
        name: name ?? this.name,
        credits: credits ?? this.credits,
        time: time ?? this.time,
        teachers: teachers ?? this.teachers,
      );

  static DatabaseCourse fromJson(Map<String, Object?> json) => DatabaseCourse(
    id: json['id'] as int?,
    cloudId: json['cloudId'] as String,
    courseCode: json['courseCode'] as String,
    name: json['name'] as String,
    credits: json['credits'] as int,
    time: json['time'] as String,
    teachers: json['teachers'] as String?,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'cloudId': cloudId,
    'courseCode': courseCode,
    'name': name,
    'credits': credits,
    'time': time,
    'teachers': teachers
  };
}