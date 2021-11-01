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


/** This is an auto generated class representing the LessonData type in your schema. */
@immutable
class LessonData extends Model {
  static const classType = const _LessonDataModelType();
  final String id;
  final String? _title;
  final String? _date;
  final String? _time;
  final String? _ownerID;
  final String? _courseCode;
  final String? _description;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get title {
    try {
      return _title!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
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
  
  String get ownerID {
    try {
      return _ownerID!;
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
  
  const LessonData._internal({required this.id, required title, required date, required time, required ownerID, required courseCode, description}): _title = title, _date = date, _time = time, _ownerID = ownerID, _courseCode = courseCode, _description = description;
  
  factory LessonData({String? id, required String title, required String date, required String time, required String ownerID, required String courseCode, String? description}) {
    return LessonData._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      date: date,
      time: time,
      ownerID: ownerID,
      courseCode: courseCode,
      description: description);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LessonData &&
      id == other.id &&
      _title == other._title &&
      _date == other._date &&
      _time == other._time &&
      _ownerID == other._ownerID &&
      _courseCode == other._courseCode &&
      _description == other._description;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LessonData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("time=" + "$_time" + ", ");
    buffer.write("ownerID=" + "$_ownerID" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("description=" + "$_description");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LessonData copyWith({String? id, String? title, String? date, String? time, String? ownerID, String? courseCode, String? description}) {
    return LessonData(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      ownerID: ownerID ?? this.ownerID,
      courseCode: courseCode ?? this.courseCode,
      description: description ?? this.description);
  }
  
  LessonData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _date = json['date'],
      _time = json['time'],
      _ownerID = json['ownerID'],
      _courseCode = json['courseCode'],
      _description = json['description'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'date': _date, 'time': _time, 'ownerID': _ownerID, 'courseCode': _courseCode, 'description': _description
  };

  static final QueryField ID = QueryField(fieldName: "lessonData.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField OWNERID = QueryField(fieldName: "ownerID");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LessonData";
    modelSchemaDefinition.pluralName = "LessonData";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
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
      key: LessonData.OWNERID,
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
  });
}

class _LessonDataModelType extends ModelType<LessonData> {
  const _LessonDataModelType();
  
  @override
  LessonData fromJson(Map<String, dynamic> jsonData) {
    return LessonData.fromJson(jsonData);
  }
}