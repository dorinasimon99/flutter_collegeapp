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


/** This is an auto generated class representing the TodoData type in your schema. */
@immutable
class TodoData extends Model {
  static const classType = const _TodoDataModelType();
  final String id;
  final String? _name;
  final bool? _done;
  final String? _ownerID;
  final String? _courseID;
  final String? _lessonID;

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
  
  bool get done {
    try {
      return _done!;
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
  
  String? get lessonID {
    return _lessonID;
  }
  
  const TodoData._internal({required this.id, required name, required done, required ownerID, required courseID, lessonID}): _name = name, _done = done, _ownerID = ownerID, _courseID = courseID, _lessonID = lessonID;
  
  factory TodoData({String? id, required String name, required bool done, required String ownerID, required String courseID, String? lessonID}) {
    return TodoData._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      done: done,
      ownerID: ownerID,
      courseID: courseID,
      lessonID: lessonID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoData &&
      id == other.id &&
      _name == other._name &&
      _done == other._done &&
      _ownerID == other._ownerID &&
      _courseID == other._courseID &&
      _lessonID == other._lessonID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TodoData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("done=" + (_done != null ? _done!.toString() : "null") + ", ");
    buffer.write("ownerID=" + "$_ownerID" + ", ");
    buffer.write("courseID=" + "$_courseID" + ", ");
    buffer.write("lessonID=" + "$_lessonID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TodoData copyWith({String? id, String? name, bool? done, String? ownerID, String? courseID, String? lessonID}) {
    return TodoData(
      id: id ?? this.id,
      name: name ?? this.name,
      done: done ?? this.done,
      ownerID: ownerID ?? this.ownerID,
      courseID: courseID ?? this.courseID,
      lessonID: lessonID ?? this.lessonID);
  }
  
  TodoData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _done = json['done'],
      _ownerID = json['ownerID'],
      _courseID = json['courseID'],
      _lessonID = json['lessonID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'done': _done, 'ownerID': _ownerID, 'courseID': _courseID, 'lessonID': _lessonID
  };

  static final QueryField ID = QueryField(fieldName: "todoData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DONE = QueryField(fieldName: "done");
  static final QueryField OWNERID = QueryField(fieldName: "ownerID");
  static final QueryField COURSEID = QueryField(fieldName: "courseID");
  static final QueryField LESSONID = QueryField(fieldName: "lessonID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TodoData";
    modelSchemaDefinition.pluralName = "TodoData";
    
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
      key: TodoData.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.DONE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.OWNERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.COURSEID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.LESSONID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _TodoDataModelType extends ModelType<TodoData> {
  const _TodoDataModelType();
  
  @override
  TodoData fromJson(Map<String, dynamic> jsonData) {
    return TodoData.fromJson(jsonData);
  }
}