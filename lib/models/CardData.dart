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
  final String? _title;
  final List<String>? _questions;
  final List<String>? _answers;
  final String? _courseCode;
  final String? _courseName;
  final bool? _isFavorite;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
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
  
  bool get isFavorite {
    try {
      return _isFavorite!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const CardData._internal({required this.id, title, required questions, required answers, required courseCode, required courseName, required isFavorite}): _title = title, _questions = questions, _answers = answers, _courseCode = courseCode, _courseName = courseName, _isFavorite = isFavorite;
  
  factory CardData({String? id, String? title, required List<String> questions, required List<String> answers, required String courseCode, required String courseName, required bool isFavorite}) {
    return CardData._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      questions: questions != null ? List<String>.unmodifiable(questions) : questions,
      answers: answers != null ? List<String>.unmodifiable(answers) : answers,
      courseCode: courseCode,
      courseName: courseName,
      isFavorite: isFavorite);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardData &&
      id == other.id &&
      _title == other._title &&
      DeepCollectionEquality().equals(_questions, other._questions) &&
      DeepCollectionEquality().equals(_answers, other._answers) &&
      _courseCode == other._courseCode &&
      _courseName == other._courseName &&
      _isFavorite == other._isFavorite;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CardData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("questions=" + (_questions != null ? _questions!.toString() : "null") + ", ");
    buffer.write("answers=" + (_answers != null ? _answers!.toString() : "null") + ", ");
    buffer.write("courseCode=" + "$_courseCode" + ", ");
    buffer.write("courseName=" + "$_courseName" + ", ");
    buffer.write("isFavorite=" + (_isFavorite != null ? _isFavorite!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CardData copyWith({String? id, String? title, List<String>? questions, List<String>? answers, String? courseCode, String? courseName, bool? isFavorite}) {
    return CardData(
      id: id ?? this.id,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      isFavorite: isFavorite ?? this.isFavorite);
  }
  
  CardData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _questions = json['questions']?.cast<String>(),
      _answers = json['answers']?.cast<String>(),
      _courseCode = json['courseCode'],
      _courseName = json['courseName'],
      _isFavorite = json['isFavorite'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'questions': _questions, 'answers': _answers, 'courseCode': _courseCode, 'courseName': _courseName, 'isFavorite': _isFavorite
  };

  static final QueryField ID = QueryField(fieldName: "cardData.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField QUESTIONS = QueryField(fieldName: "questions");
  static final QueryField ANSWERS = QueryField(fieldName: "answers");
  static final QueryField COURSECODE = QueryField(fieldName: "courseCode");
  static final QueryField COURSENAME = QueryField(fieldName: "courseName");
  static final QueryField ISFAVORITE = QueryField(fieldName: "isFavorite");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CardData";
    modelSchemaDefinition.pluralName = "CardData";
    
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
      key: CardData.TITLE,
      isRequired: false,
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
      key: CardData.ISFAVORITE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
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