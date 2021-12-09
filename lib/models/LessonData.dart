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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the LessonData type in your schema. */
@immutable
class LessonData extends Model {
  static const classType = const _LessonDataModelType();
  final String id;
  final String? _date;
  final String? _time;
  final String? _courseCode;
  final String? _description;
  final String? _title;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get date {
    try {
      return _date!;
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
  
  String get courseCode {
    try {
      return _courseCode!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get description {
    return _description;
  }
  
  String get title {
    try {
      return _title!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const LessonData._internal({required this.id, required date, required time, required courseCode, description, required title}): _date = date, _time = time, _courseCode = courseCode, _description = description, _title = title;
  
  factory LessonData({String? id, required String date, required String time, required String courseCode, String? description, required String title}) {
    return LessonData._internal(
      id: id == null ? UUID.getUUID() : id,
      date: date,
      time: time,
      courseCode: courseCode,
      description: description,
      title: title);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LessonData &&
      id == other.id &&
      _date == other._date &&
      _time == other._time &&
      _courseCode == other._courseCode &&
      _description == other._description &&
      _title == other._title;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LessonData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("time=" + "$_time" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("title=" + "$_title");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LessonData copyWith({String? id, String? date, String? time, String? courseCode, String? description, String? title}) {
    return LessonData(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      courseCode: courseCode ?? this.courseCode,
      description: description ?? this.description,
      title: title ?? this.title);
  }
  
  LessonData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _date = json['date'],
      _time = json['time'],
      _courseCode = json['courseCode'],
      _description = json['description'],
      _title = json['title'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'date': _date, 'time': _time, 'courseCode': _courseCode, 'description': _description, 'title': _title
  };

  static final QueryField ID = QueryField(fieldName: "lessonData.id");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LessonData";
    modelSchemaDefinition.pluralName = "LessonData";
    
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
      key: LessonData.DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.TIME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _LessonDataModelType extends ModelType<LessonData> {
  const _LessonDataModelType();
  
  @override
  LessonData fromJson(Map<String, dynamic> jsonData) {
    return LessonData.fromJson(jsonData);
  }
}