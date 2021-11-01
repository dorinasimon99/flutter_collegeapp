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


/** This is an auto generated class representing the QuizData type in your schema. */
@immutable
class QuizData extends Model {
  static const classType = const _QuizDataModelType();
  final String id;
  final String? _lessonID;
  final String? _title;
  final List<String>? _questions;
  final List<String>? _answers;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get lessonID {
    try {
      return _lessonID!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get title {
    try {
      return _title!;
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
  
  const QuizData._internal({required this.id, required lessonID, required title, required questions, required answers}): _lessonID = lessonID, _title = title, _questions = questions, _answers = answers;
  
  factory QuizData({String? id, required String lessonID, required String title, required List<String> questions, required List<String> answers}) {
    return QuizData._internal(
      id: id == null ? UUID.getUUID() : id,
      lessonID: lessonID,
      title: title,
      questions: questions != null ? List<String>.unmodifiable(questions) : questions,
      answers: answers != null ? List<String>.unmodifiable(answers) : answers);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizData &&
      id == other.id &&
      _lessonID == other._lessonID &&
      _title == other._title &&
      DeepCollectionEquality().equals(_questions, other._questions) &&
      DeepCollectionEquality().equals(_answers, other._answers);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("QuizData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("lessonID=" + "$_lessonID" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("questions=" + (_questions != null ? _questions!.toString() : "null") + ", ");
    buffer.write("answers=" + (_answers != null ? _answers!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  QuizData copyWith({String? id, String? lessonID, String? title, List<String>? questions, List<String>? answers}) {
    return QuizData(
      id: id ?? this.id,
      lessonID: lessonID ?? this.lessonID,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers);
  }
  
  QuizData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _lessonID = json['lessonID'],
      _title = json['title'],
      _questions = json['questions']?.cast<String>(),
      _answers = json['answers']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'lessonID': _lessonID, 'title': _title, 'questions': _questions, 'answers': _answers
  };

  static final QueryField ID = QueryField(fieldName: "quizData.id");
  static final QueryField LESSONID = QueryField(fieldName: "lessonID");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField QUESTIONS = QueryField(fieldName: "questions");
  static final QueryField ANSWERS = QueryField(fieldName: "answers");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "QuizData";
    modelSchemaDefinition.pluralName = "QuizData";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.LESSONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.QUESTIONS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.ANSWERS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}

class _QuizDataModelType extends ModelType<QuizData> {
  const _QuizDataModelType();
  
  @override
  QuizData fromJson(Map<String, dynamic> jsonData) {
    return QuizData.fromJson(jsonData);
  }
}