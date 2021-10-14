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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserData type in your schema. */
@immutable
class UserData extends Model {
  static const classType = const _UserDataModelType();
  final String id;
  final String? _name;
  final String? _username;
  final String? _role;
  final List<UserCourse>? _courses;

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
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get role {
    try {
      return _role!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<UserCourse>? get courses {
    return _courses;
  }
  
  const UserData._internal({required this.id, required name, required username, required role, courses}): _name = name, _username = username, _role = role, _courses = courses;
  
  factory UserData({String? id, required String name, required String username, required String role, List<UserCourse>? courses}) {
    return UserData._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      username: username,
      role: role,
      courses: courses != null ? List<UserCourse>.unmodifiable(courses) : courses);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserData &&
      id == other.id &&
      _name == other._name &&
      _username == other._username &&
      _role == other._role &&
      DeepCollectionEquality().equals(_courses, other._courses);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("role=" + "$_role");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserData copyWith({String? id, String? name, String? username, String? role, List<UserCourse>? courses}) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      role: role ?? this.role,
      courses: courses ?? this.courses);
  }
  
  UserData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _username = json['username'],
      _role = json['role'],
      _courses = json['courses'] is List
        ? (json['courses'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserCourse.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'username': _username, 'role': _role, 'courses': _courses?.map((UserCourse? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "userData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static final QueryField COURSES = QueryField(
    fieldName: "courses",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserCourse).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserData";
    modelSchemaDefinition.pluralName = "UserData";
    
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
      key: UserData.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserData.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserData.ROLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UserData.COURSES,
      isRequired: false,
      ofModelName: (UserCourse).toString(),
      associatedKey: UserCourse.USER
    ));
  });
}

class _UserDataModelType extends ModelType<UserData> {
  const _UserDataModelType();
  
  @override
  UserData fromJson(Map<String, dynamic> jsonData) {
    return UserData.fromJson(jsonData);
  }
}