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


/** This is an auto generated class representing the QuizData type in your schema. */
@immutable
class QuizData extends Model {
  static const classType = const _QuizDataModelType();
  final String id;
  final String? _title;
  final String? _lessonID;
  final String? _link;
  final bool? _visible;
  final String? _description;

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
  
  String get lessonID {
    try {
      return _lessonID!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get link {
    try {
      return _link!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  bool get visible {
    try {
      return _visible!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get description {
    return _description;
  }
  
  const QuizData._internal({required this.id, required title, required lessonID, required link, required visible, description}): _title = title, _lessonID = lessonID, _link = link, _visible = visible, _description = description;
  
  factory QuizData({String? id, required String title, required String lessonID, required String link, required bool visible, String? description}) {
    return QuizData._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      lessonID: lessonID,
      link: link,
      visible: visible,
      description: description);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizData &&
      id == other.id &&
      _title == other._title &&
      _lessonID == other._lessonID &&
      _link == other._link &&
      _visible == other._visible &&
      _description == other._description;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("QuizData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("lessonID=" + "$_lessonID" + ", ");
    buffer.write("link=" + "$_link" + ", ");
    buffer.write("visible=" + (_visible != null ? _visible!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  QuizData copyWith({String? id, String? title, String? lessonID, String? link, bool? visible, String? description}) {
    return QuizData(
      id: id ?? this.id,
      title: title ?? this.title,
      lessonID: lessonID ?? this.lessonID,
      link: link ?? this.link,
      visible: visible ?? this.visible,
      description: description ?? this.description);
  }
  
  QuizData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _lessonID = json['lessonID'],
      _link = json['link'],
      _visible = json['visible'],
      _description = json['description'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'lessonID': _lessonID, 'link': _link, 'visible': _visible, 'description': _description
  };

  static final QueryField ID = QueryField(fieldName: "quizData.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField LESSONID = QueryField(fieldName: "lessonID");
  static final QueryField LINK = QueryField(fieldName: "link");
  static final QueryField VISIBLE = QueryField(fieldName: "visible");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "QuizData";
    modelSchemaDefinition.pluralName = "QuizData";
    
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
      key: QuizData.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.LESSONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.LINK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.VISIBLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuizData.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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