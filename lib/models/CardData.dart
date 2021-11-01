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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the CardData type in your schema. */
@immutable
class CardData extends Model {
  static const classType = const _CardDataModelType();
  final String id;
  final String? _courseCode;
  final String? _courseName;
  final List<String>? _questions;
  final List<String>? _answers;

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
  
  String get courseName {
    try {
      return _courseName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<String> get questions {
    try {
      return _questions!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<String> get answers {
    try {
      return _answers!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const CardData._internal({required this.id, required courseCode, required courseName, required questions, required answers}): _courseCode = courseCode, _courseName = courseName, _questions = questions, _answers = answers;
  
  factory CardData({String? id, required String courseCode, required String courseName, required List<String> questions, required List<String> answers}) {
    return CardData._internal(
      id: id == null ? UUID.getUUID() : id,
      courseCode: courseCode,
      courseName: courseName,
      questions: questions != null ? List<String>.unmodifiable(questions) : questions,
      answers: answers != null ? List<String>.unmodifiable(answers) : answers);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardData &&
      id == other.id &&
      _courseCode == other._courseCode &&
      _courseName == other._courseName &&
      DeepCollectionEquality().equals(_questions, other._questions) &&
      DeepCollectionEquality().equals(_answers, other._answers);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CardData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("courseName=" + "$_courseName" + ", ");
    buffer.write("questions=" + (_questions != null ? _questions!.toString() : "null") + ", ");
    buffer.write("answers=" + (_answers != null ? _answers!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CardData copyWith({String? id, String? courseCode, String? courseName, List<String>? questions, List<String>? answers}) {
    return CardData(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers);
  }
  
  CardData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _courseCode = json['courseCode'],
      _courseName = json['courseName'],
      _questions = json['questions']?.cast<String>(),
      _answers = json['answers']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'courseCode': _courseCode, 'courseName': _courseName, 'questions': _questions, 'answers': _answers
  };

  static final QueryField ID = QueryField(fieldName: "cardData.id");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField COURSENAME = QueryField(fieldName: "courseName");
  static final QueryField QUESTIONS = QueryField(fieldName: "questions");
  static final QueryField ANSWERS = QueryField(fieldName: "answers");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CardData";
    modelSchemaDefinition.pluralName = "CardData";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CardData.COURSECODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CardData.COURSENAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CardData.QUESTIONS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CardData.ANSWERS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}

class _CardDataModelType extends ModelType<CardData> {
  const _CardDataModelType();
  
  @override
  CardData fromJson(Map<String, dynamic> jsonData) {
    return CardData.fromJson(jsonData);
  }
}