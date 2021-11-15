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
  final bool? _done;
  final String? _owner;
  final String? _courseCode;
  final String? _lessonID;
  final String? _deadline;
  final String? _name;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const TodoData._internal({required this.id, required done, required owner, required courseCode, lessonID, deadline, required name}): _done = done, _owner = owner, _courseCode = courseCode, _lessonID = lessonID, _deadline = deadline, _name = name;
  
  factory TodoData({String? id, required bool done, required String owner, required String courseCode, String? lessonID, String? deadline, required String name}) {
    return TodoData._internal(
      id: id == null ? UUID.getUUID() : id,
      done: done,
      owner: owner,
      courseCode: courseCode,
      lessonID: lessonID,
      deadline: deadline,
      name: name);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoData &&
      id == other.id &&
      _done == other._done &&
      _owner == other._owner &&
      _courseCode == other._courseCode &&
      _lessonID == other._lessonID &&
      _deadline == other._deadline &&
      _name == other._name;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TodoData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("done=" + (_done != null ? _done!.toString() : "null") + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("lessonID=" + "$_lessonID" + ", ");
    buffer.write("deadline=" + "$_deadline" + ", ");
    buffer.write("name=" + "$_name");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TodoData copyWith({String? id, bool? done, String? owner, String? courseCode, String? lessonID, String? deadline, String? name}) {
    return TodoData(
      id: id ?? this.id,
      done: done ?? this.done,
      owner: owner ?? this.owner,
      courseCode: courseCode ?? this.courseCode,
      lessonID: lessonID ?? this.lessonID,
      deadline: deadline ?? this.deadline,
      name: name ?? this.name);
  }
  
  TodoData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _done = json['done'],
      _owner = json['owner'],
      _courseCode = json['courseCode'],
      _lessonID = json['lessonID'],
      _deadline = json['deadline'],
      _name = json['name'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'done': _done, 'owner': _owner, 'courseCode': _courseCode, 'lessonID': _lessonID, 'deadline': _deadline, 'name': _name
  };

  static final QueryField ID = QueryField(fieldName: "todoData.id");
  static final QueryField DONE = QueryField(fieldName: "done");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField LESSONID = QueryField(fieldName: "lessonID");
  static final QueryField DEADLINE = QueryField(fieldName: "deadline");
  static final QueryField NAME = QueryField(fieldName: "name");
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TodoData.NAME,
      isRequired: true,
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