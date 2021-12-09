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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the CourseData type in your schema. */
@immutable
class CourseData extends Model {
  static const classType = const _CourseDataModelType();
  final String id;
  final String? _name;
  final int? _credits;
  final List<String>? _teachers;
  final String? _courseCode;

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
  
  int get credits {
    try {
      return _credits!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<String>? get teachers {
    return _teachers;
  }
  
  String get courseCode {
    try {
      return _courseCode!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const CourseData._internal({required this.id, required name, required credits, teachers, required courseCode}): _name = name, _credits = credits, _teachers = teachers, _courseCode = courseCode;
  
  factory CourseData({String? id, required String name, required int credits, List<String>? teachers, required String courseCode}) {
    return CourseData._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      credits: credits,
      teachers: teachers != null ? List<String>.unmodifiable(teachers) : teachers,
      courseCode: courseCode);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseData &&
      id == other.id &&
      _name == other._name &&
      _credits == other._credits &&
      DeepCollectionEquality().equals(_teachers, other._teachers) &&
      _courseCode == other._courseCode;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CourseData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("credits=" + (_credits != null ? _credits!.toString() : "null") + ", ");
    buffer.write("teachers=" + (_teachers != null ? _teachers!.toString() : "null") + ", ");
    buffer.write("courseCode=" + "$_courseCode");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CourseData copyWith({String? id, String? name, int? credits, List<String>? teachers, String? courseCode}) {
    return CourseData(
      id: id ?? this.id,
      name: name ?? this.name,
      credits: credits ?? this.credits,
      teachers: teachers ?? this.teachers,
      courseCode: courseCode ?? this.courseCode);
  }
  
  CourseData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _credits = (json['credits'] as num?)?.toInt(),
      _teachers = json['teachers']?.cast<String>(),
      _courseCode = json['courseCode'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'credits': _credits, 'teachers': _teachers, 'courseCode': _courseCode
  };

  static final QueryField ID = QueryField(fieldName: "courseData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField CREDITS = QueryField(fieldName: "credits");
  static final QueryField TEACHERS = QueryField(fieldName: "teachers");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
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
      key: CourseData.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.CREDITS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.TEACHERS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CourseData.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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