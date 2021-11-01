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
  final String? _owner;
  final String? _courseCode;
  final String? _lessonID;
  final String? _deadline;

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
  
  String get owner {
    try {
      return _owner!;
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
  
  String? get lessonID {
    return _lessonID;
  }
  
  String? get deadline {
    return _deadline;
  }
  
  const TodoData._internal({required this.id, required name, required done, required owner, required courseCode, lessonID, deadline}): _name = name, _done = done, _owner = owner, _courseCode = courseCode, _lessonID = lessonID, _deadline = deadline;
  
  factory TodoData({String? id, required String name, required bool done, required String owner, required String courseCode, String? lessonID, String? deadline}) {
    return TodoData._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      done: done,
      owner: owner,
      courseCode: courseCode,
      lessonID: lessonID,
      deadline: deadline);
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
      _owner == other._owner &&
      _courseCode == other._courseCode &&
      _lessonID == other._lessonID &&
      _deadline == other._deadline;
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
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("lessonID=" + "$_lessonID" + ", ");
    buffer.write("deadline=" + "$_deadline");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TodoData copyWith({String? id, String? name, bool? done, String? owner, String? courseCode, String? lessonID, String? deadline}) {
    return TodoData(
      id: id ?? this.id,
      name: name ?? this.name,
      done: done ?? this.done,
      owner: owner ?? this.owner,
      courseCode: courseCode ?? this.courseCode,
      lessonID: lessonID ?? this.lessonID,
      deadline: deadline ?? this.deadline);
  }
  
  TodoData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _done = json['done'],
      _owner = json['owner'],
      _courseCode = json['courseCode'],
      _lessonID = json['lessonID'],
      _deadline = json['deadline'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'done': _done, 'owner': _owner, 'courseCode': _courseCode, 'lessonID': _lessonID, 'deadline': _deadline
  };

  static final QueryField ID = QueryField(fieldName: "todoData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DONE = QueryField(fieldName: "done");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField LESSONID = QueryField(fieldName: "lessonID");
  static final QueryField DEADLINE = QueryField(fieldName: "deadline");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TodoData";
    modelSchemaDefinition.pluralName = "TodoData";
    
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
      key: TodoData.OWNER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.LESSONID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.DEADLINE,
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