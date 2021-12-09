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


/** This is an auto generated class representing the CommentData type in your schema. */
@immutable
class CommentData extends Model {
  static const classType = const _CommentDataModelType();
  final String id;
  final String? _courseCode;
  final String? _teachername;
  final String? _name;
  final String? _comment;

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
  
  String get teachername {
    try {
      return _teachername!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
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
  
  const CommentData._internal({required this.id, required courseCode, required teachername, name, required comment}): _courseCode = courseCode, _teachername = teachername, _name = name, _comment = comment;
  
  factory CommentData({String? id, required String courseCode, required String teachername, String? name, required String comment}) {
    return CommentData._internal(
      id: id == null ? UUID.getUUID() : id,
      courseCode: courseCode,
      teachername: teachername,
      name: name,
      comment: comment);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentData &&
      id == other.id &&
      _courseCode == other._courseCode &&
      _teachername == other._teachername &&
      _name == other._name &&
      _comment == other._comment;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CommentData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("teachername=" + "$_teachername" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("comment=" + "$_comment");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CommentData copyWith({String? id, String? courseCode, String? teachername, String? name, String? comment}) {
    return CommentData(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      teachername: teachername ?? this.teachername,
      name: name ?? this.name,
      comment: comment ?? this.comment);
  }
  
  CommentData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _courseCode = json['courseCode'],
      _teachername = json['teachername'],
      _name = json['name'],
      _comment = json['comment'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'courseCode': _courseCode, 'teachername': _teachername, 'name': _name, 'comment': _comment
  };

  static final QueryField ID = QueryField(fieldName: "commentData.id");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField TEACHERNAME = QueryField(fieldName: "teachername");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField COMMENT = QueryField(fieldName: "comment");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CommentData";
    modelSchemaDefinition.pluralName = "CommentData";
    
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
      key: CommentData.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CommentData.TEACHERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
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
  });
}

class _CommentDataModelType extends ModelType<CommentData> {
  const _CommentDataModelType();
  
  @override
  CommentData fromJson(Map<String, dynamic> jsonData) {
    return CommentData.fromJson(jsonData);
  }
}