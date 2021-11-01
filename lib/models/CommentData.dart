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


/** This is an auto generated class representing the CommentData type in your schema. */
@immutable
class CommentData extends Model {
  static const classType = const _CommentDataModelType();
  final String id;
  final String? _name;
  final String? _comment;
  final String? _coursename;
  final String? _teachername;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String get comment {
    try {
      return _comment!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get coursename {
    try {
      return _coursename!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get teachername {
    try {
      return _teachername!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const CommentData._internal({required this.id, name, required comment, required coursename, required teachername}): _name = name, _comment = comment, _coursename = coursename, _teachername = teachername;
  
  factory CommentData({String? id, String? name, required String comment, required String coursename, required String teachername}) {
    return CommentData._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      comment: comment,
      coursename: coursename,
      teachername: teachername);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentData &&
      id == other.id &&
      _name == other._name &&
      _comment == other._comment &&
      _coursename == other._coursename &&
      _teachername == other._teachername;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CommentData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("coursename=" + "$_coursename" + ", ");
    buffer.write("teachername=" + "$_teachername");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CommentData copyWith({String? id, String? name, String? comment, String? coursename, String? teachername}) {
    return CommentData(
      id: id ?? this.id,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      coursename: coursename ?? this.coursename,
      teachername: teachername ?? this.teachername);
  }
  
  CommentData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _comment = json['comment'],
      _coursename = json['coursename'],
      _teachername = json['teachername'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'comment': _comment, 'coursename': _coursename, 'teachername': _teachername
  };

  static final QueryField ID = QueryField(fieldName: "commentData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField COMMENT = QueryField(fieldName: "comment");
  static final QueryField COURSENAME = QueryField(fieldName: "coursename");
  static final QueryField TEACHERNAME = QueryField(fieldName: "teachername");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CommentData";
    modelSchemaDefinition.pluralName = "CommentData";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CommentData.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CommentData.COMMENT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CommentData.COURSENAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CommentData.TEACHERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CommentDataModelType extends ModelType<CommentData> {
  const _CommentDataModelType();
  
  @override
  CommentData fromJson(Map<String, dynamic> jsonData) {
    return CommentData.fromJson(jsonData);
  }
}