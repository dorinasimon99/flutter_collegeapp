/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserCourse type in your schema. */
@immutable
class UserCourse extends Model {
  static const classType = const _UserCourseModelType();
  final String id;
  final UserData? _user;
  final CourseData? _course;
  final String? _rating;
  final int? _ratingNum;
  final int? _semester;
  final int? _grade;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  UserData get user {
    try {
      return _user!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  CourseData get course {
    try {
      return _course!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get rating {
    return _rating;
  }
  
  int? get ratingNum {
    return _ratingNum;
  }
  
  int? get semester {
    return _semester;
  }
  
  int? get grade {
    return _grade;
  }
  
  const UserCourse._internal({required this.id, required user, required course, rating, ratingNum, semester, grade}): _user = user, _course = course, _rating = rating, _ratingNum = ratingNum, _semester = semester, _grade = grade;
  
  factory UserCourse({String? id, required UserData user, required CourseData course, String? rating, int? ratingNum, int? semester, int? grade}) {
    return UserCourse._internal(
      id: id == null ? UUID.getUUID() : id,
      user: user,
      course: course,
      rating: rating,
      ratingNum: ratingNum,
      semester: semester,
      grade: grade);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCourse &&
      id == other.id &&
      _user == other._user &&
      _course == other._course &&
      _rating == other._rating &&
      _ratingNum == other._ratingNum &&
      _semester == other._semester &&
      _grade == other._grade;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserCourse {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("course=" + (_course != null ? _course!.toString() : "null") + ", ");
    buffer.write("rating=" + "$_rating" + ", ");
    buffer.write("ratingNum=" + (_ratingNum != null ? _ratingNum!.toString() : "null") + ", ");
    buffer.write("semester=" + (_semester != null ? _semester!.toString() : "null") + ", ");
    buffer.write("grade=" + (_grade != null ? _grade!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserCourse copyWith({String? id, UserData? user, CourseData? course, String? rating, int? ratingNum, int? semester, int? grade}) {
    return UserCourse(
      id: id ?? this.id,
      user: user ?? this.user,
      course: course ?? this.course,
      rating: rating ?? this.rating,
      ratingNum: ratingNum ?? this.ratingNum,
      semester: semester ?? this.semester,
      grade: grade ?? this.grade);
  }
  
  UserCourse.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user']?['serializedData'] != null
        ? UserData.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _course = json['course']?['serializedData'] != null
        ? CourseData.fromJson(new Map<String, dynamic>.from(json['course']['serializedData']))
        : null,
      _rating = json['rating'],
      _ratingNum = (json['ratingNum'] as num?)?.toInt(),
      _semester = (json['semester'] as num?)?.toInt(),
      _grade = (json['grade'] as num?)?.toInt();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user?.toJson(), 'course': _course?.toJson(), 'rating': _rating, 'ratingNum': _ratingNum, 'semester': _semester, 'grade': _grade
  };

  static final QueryField ID = QueryField(fieldName: "userCourse.id");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserData).toString()));
  static final QueryField COURSE = QueryField(
    fieldName: "course",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (CourseData).toString()));
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField RATINGNUM = QueryField(fieldName: "ratingNum");
  static final QueryField SEMESTER = QueryField(fieldName: "semester");
  static final QueryField GRADE = QueryField(fieldName: "grade");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserCourse";
    modelSchemaDefinition.pluralName = "UserCourses";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UserCourse.USER,
      isRequired: true,
      targetName: "userCourseUserId",
      ofModelName: (UserData).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UserCourse.COURSE,
      isRequired: true,
      targetName: "userCourseCourseId",
      ofModelName: (CourseData).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.RATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.RATINGNUM,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.SEMESTER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.GRADE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
  });
}

class _UserCourseModelType extends ModelType<UserCourse> {
  const _UserCourseModelType();
  
  @override
  UserCourse fromJson(Map<String, dynamic> jsonData) {
    return UserCourse.fromJson(jsonData);
  }
}