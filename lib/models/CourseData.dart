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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the CourseData type in your schema. */
@immutable
class CourseData extends Model {
  static const classType = const _CourseDataModelType();
  final String id;
  final String? _courseCode;
  final String? _name;
  final List<UserCourse>? _users;
  final int? _credits;
  final String? _time;
  final List<String>? _teachers;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get courseCode {
    try {
      return _courseCode!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<UserCourse>? get users {
    return _users;
  }
  
  int get credits {
    try {
      return _credits!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get time {
    try {
      return _time!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<String>? get teachers {
    return _teachers;
  }
  
  const CourseData._internal({required this.id, required courseCode, required name, users, required credits, required time, teachers}): _courseCode = courseCode, _name = name, _users = users, _credits = credits, _time = time, _teachers = teachers;
  
  factory CourseData({String? id, required String courseCode, required String name, List<UserCourse>? users, required int credits, required String time, List<String>? teachers}) {
    return CourseData._internal(
      id: id == null ? UUID.getUUID() : id,
      courseCode: courseCode,
      name: name,
      users: users != null ? List<UserCourse>.unmodifiable(users) : users,
      credits: credits,
      time: time,
      teachers: teachers != null ? List<String>.unmodifiable(teachers) : teachers);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseData &&
      id == other.id &&
      _courseCode == other._courseCode &&
      _name == other._name &&
      DeepCollectionEquality().equals(_users, other._users) &&
      _credits == other._credits &&
      _time == other._time &&
      DeepCollectionEquality().equals(_teachers, other._teachers);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CourseData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("credits=" + (_credits != null ? _credits!.toString() : "null") + ", ");
    buffer.write("time=" + "$_time" + ", ");
    buffer.write("teachers=" + (_teachers != null ? _teachers!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CourseData copyWith({String? id, String? courseCode, String? name, List<UserCourse>? users, int? credits, String? time, List<String>? teachers}) {
    return CourseData(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      name: name ?? this.name,
      users: users ?? this.users,
      credits: credits ?? this.credits,
      time: time ?? this.time,
      teachers: teachers ?? this.teachers);
  }
  
  CourseData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _courseCode = json['courseCode'],
      _name = json['name'],
      _users = json['users'] is List
        ? (json['users'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserCourse.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _credits = (json['credits'] as num?)?.toInt(),
      _time = json['time'],
      _teachers = json['teachers']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'courseCode': _courseCode, 'name': _name, 'users': _users?.map((UserCourse? e) => e?.toJson()).toList(), 'credits': _credits, 'time': _time, 'teachers': _teachers
  };

  static final QueryField ID = QueryField(fieldName: "courseData.id");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField USERS = QueryField(
    fieldName: "users",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserCourse).toString()));
  static final QueryField CREDITS = QueryField(fieldName: "credits");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField TEACHERS = QueryField(fieldName: "teachers");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CourseData";
    modelSchemaDefinition.pluralName = "CourseData";
    
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
      key: CourseData.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: CourseData.USERS,
      isRequired: false,
      ofModelName: (UserCourse).toString(),
      associatedKey: UserCourse.COURSE
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.CREDITS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.TIME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.TEACHERS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}

class _CourseDataModelType extends ModelType<CourseData> {
  const _CourseDataModelType();
  
  @override
  CourseData fromJson(Map<String, dynamic> jsonData) {
    return CourseData.fromJson(jsonData);
  }
}