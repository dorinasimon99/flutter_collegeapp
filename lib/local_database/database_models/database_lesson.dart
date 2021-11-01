class DatabaseLesson{
  final int? id;
  final String cloudId;
  final String title;
  final String date;
  final String time;
  final String ownerId;
  final String courseCode;
  final String description;

  const DatabaseLesson({
    this.id,
    required this.cloudId,
    required this.title,
    required this.date,
    required this.time,
    required this.ownerId,
    required this.courseCode,
    required this.description,
  });

  DatabaseLesson copy({
    int? id,
    String? cloudId,
    String? title,
    String? date,
    String? time,
    String? ownerId,
    String? courseCode,
    String? description,
  }) =>
      DatabaseLesson(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        title: courseCode ?? this.courseCode,
        date: date ?? this.date,
        time: time ?? this.time,
        ownerId: ownerId ?? this.ownerId,
        courseCode: courseCode ?? this.courseCode,
        description: description ?? this.description,
      );

  static DatabaseLesson fromJson(Map<String, Object?> json) => DatabaseLesson(
    id: json['id'] as int?,
    cloudId: json['cloudId'] as String,
    title: json['title'] as String,
    date: json['name'] as String,
    time: json['time'] as String,
    ownerId: json['ownerId'] as String,
    courseCode: json['courseCode'] as String,
    description: json['description'] as String,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'cloudId': cloudId,
    'title': title,
    'date': date,
    'time': time,
    'ownerId': ownerId,
    'courseCode': courseCode,
    'description': description,
  };
}