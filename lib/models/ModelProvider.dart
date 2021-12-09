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
import 'CardData.dart';
import 'CommentData.dart';
import 'CourseData.dart';
import 'LessonData.dart';
import 'QuizData.dart';
import 'TodoData.dart';
import 'UserCourse.dart';
import 'UserData.dart';

export 'CardData.dart';
export 'CommentData.dart';
export 'CourseData.dart';
export 'LessonData.dart';
export 'QuizData.dart';
export 'TodoData.dart';
export 'UserCourse.dart';
export 'UserData.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "8fe3a4b0c9490b38a86287a5ccb3ae55";
  @override
  List<ModelSchema> modelSchemas = [CardData.schema, CommentData.schema, CourseData.schema, LessonData.schema, QuizData.schema, TodoData.schema, UserCourse.schema, UserData.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
    case "CardData": {
    return CardData.classType;
    }
    break;
    case "CommentData": {
    return CommentData.classType;
    }
    break;
    case "CourseData": {
    return CourseData.classType;
    }
    break;
    case "LessonData": {
    return LessonData.classType;
    }
    break;
    case "QuizData": {
    return QuizData.classType;
    }
    break;
    case "TodoData": {
    return TodoData.classType;
    }
    break;
    case "UserCourse": {
    return UserCourse.classType;
    }
    break;
    case "UserData": {
    return UserData.classType;
    }
    break;
    default: {
    throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
    }
  }
}