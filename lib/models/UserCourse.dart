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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserCourse type in your schema. */
@immutable
class UserCourse extends Model {
  static const classType = const _UserCourseModelType();
  final String id;
  final String? _userID;
  final String? _courseCode;
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
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get courseCode {
    try {
      return _courseCode!;
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
  
  const UserCourse._internal({required this.id, required userID, required courseCode, rating, ratingNum, semester, grade}): _userID = userID, _courseCode = courseCode, _rating = rating, _ratingNum = ratingNum, _semester = semester, _grade = grade;
  
  factory UserCourse({String? id, required String userID, required String courseCode, String? rating, int? ratingNum, int? semester, int? grade}) {
    return UserCourse._internal(
      id: id == null ? UUID.getUUID() : id,
      userID: userID,
      courseCode: courseCode,
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
      _userID == other._userID &&
      _courseCode == other._courseCode &&
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
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("rating=" + "$_rating" + ", ");
    buffer.write("ratingNum=" + (_ratingNum != null ? _ratingNum!.toString() : "null") + ", ");
    buffer.write("semester=" + (_semester != null ? _semester!.toString() : "null") + ", ");
    buffer.write("grade=" + (_grade != null ? _grade!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserCourse copyWith({String? id, String? userID, String? courseCode, String? rating, int? ratingNum, int? semester, int? grade}) {
    return UserCourse(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      courseCode: courseCode ?? this.courseCode,
      rating: rating ?? this.rating,
      ratingNum: ratingNum ?? this.ratingNum,
      semester: semester ?? this.semester,
      grade: grade ?? this.grade);
  }
  
  UserCourse.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userID = json['userID'],
      _courseCode = json['courseCode'],
      _rating = json['rating'],
      _ratingNum = (json['ratingNum'] as num?)?.toInt(),
      _semester = (json['semester'] as num?)?.toInt(),
      _grade = (json['grade'] as num?)?.toInt();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userID': _userID, 'courseCode': _courseCode, 'rating': _rating, 'ratingNum': _ratingNum, 'semester': _semester, 'grade': _grade
  };

  static final QueryField ID = QueryField(fieldName: "userCourse.id");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField RATINGNUM = QueryField(fieldName: "ratingNum");
  static final QueryField SEMESTER = QueryField(fieldName: "semester");
  static final QueryField GRADE = QueryField(fieldName: "grade");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserCourse";
    modelSchemaDefinition.pluralName = "UserCourses";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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