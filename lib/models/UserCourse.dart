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
  final String? _name;
  final String? _courseCode;
  final String? _rating;
  final int? _ratingNum;
  final int? _semester;
  final int? _grade;
  final String? _username;
  final bool? _visible;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
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
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  bool? get visible {
    return _visible;
  }
  
  const UserCourse._internal({required this.id, required name, required courseCode, rating, ratingNum, semester, grade, required username, visible}): _name = name, _courseCode = courseCode, _rating = rating, _ratingNum = ratingNum, _semester = semester, _grade = grade, _username = username, _visible = visible;
  
  factory UserCourse({String? id, required String name, required String courseCode, String? rating, int? ratingNum, int? semester, int? grade, required String username, bool? visible}) {
    return UserCourse._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      courseCode: courseCode,
      rating: rating,
      ratingNum: ratingNum,
      semester: semester,
      grade: grade,
      username: username,
      visible: visible);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCourse &&
      id == other.id &&
      _name == other._name &&
      _courseCode == other._courseCode &&
      _rating == other._rating &&
      _ratingNum == other._ratingNum &&
      _semester == other._semester &&
      _grade == other._grade &&
      _username == other._username &&
      _visible == other._visible;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserCourse {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("rating=" + "$_rating" + ", ");
    buffer.write("ratingNum=" + (_ratingNum != null ? _ratingNum!.toString() : "null") + ", ");
    buffer.write("semester=" + (_semester != null ? _semester!.toString() : "null") + ", ");
    buffer.write("grade=" + (_grade != null ? _grade!.toString() : "null") + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("visible=" + (_visible != null ? _visible!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserCourse copyWith({String? id, String? name, String? courseCode, String? rating, int? ratingNum, int? semester, int? grade, String? username, bool? visible}) {
    return UserCourse(
      id: id ?? this.id,
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
      rating: rating ?? this.rating,
      ratingNum: ratingNum ?? this.ratingNum,
      semester: semester ?? this.semester,
      grade: grade ?? this.grade,
      username: username ?? this.username,
      visible: visible ?? this.visible);
  }
  
  UserCourse.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _courseCode = json['courseCode'],
      _rating = json['rating'],
      _ratingNum = json['ratingNum'],
      _semester = json['semester'],
      _grade = json['grade'],
      _username = json['username'],
      _visible = json['visible'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'courseCode': _courseCode, 'rating': _rating, 'ratingNum': _ratingNum, 'semester': _semester, 'grade': _grade, 'username': _username, 'visible': _visible
  };

  static final QueryField ID = QueryField(fieldName: "userCourse.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField RATINGNUM = QueryField(fieldName: "ratingNum");
  static final QueryField SEMESTER = QueryField(fieldName: "semester");
  static final QueryField GRADE = QueryField(fieldName: "grade");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField VISIBLE = QueryField(fieldName: "visible");
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.NAME,
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserCourse.VISIBLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
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