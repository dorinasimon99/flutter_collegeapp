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
  final String? _ownerID;
  final String? _courseID;

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
  
  String get ownerID {
    try {
      return _ownerID!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get courseID {
    try {
      return _courseID!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const LessonData._internal({required this.id, required title, required ownerID, required courseID}): _title = title, _ownerID = ownerID, _courseID = courseID;
  
  factory LessonData({String? id, required String title, required String ownerID, required String courseID}) {
    return LessonData._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      ownerID: ownerID,
      courseID: courseID);
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
      _ownerID == other._ownerID &&
      _courseID == other._courseID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LessonData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("ownerID=" + "$_ownerID" + ", ");
    buffer.write("courseID=" + "$_courseID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LessonData copyWith({String? id, String? title, String? ownerID, String? courseID}) {
    return LessonData(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerID: ownerID ?? this.ownerID,
      courseID: courseID ?? this.courseID);
  }
  
  LessonData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _ownerID = json['ownerID'],
      _courseID = json['courseID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'ownerID': _ownerID, 'courseID': _courseID
  };

  static final QueryField ID = QueryField(fieldName: "lessonData.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField OWNERID = QueryField(fieldName: "ownerID");
  static final QueryField COURSEID = QueryField(fieldName: "courseID");
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
      key: LessonData.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.OWNERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LessonData.COURSEID,
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