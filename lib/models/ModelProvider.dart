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
import 'CommentData.dart';
import 'CourseData.dart';
import 'LessonData.dart';
import 'TodoData.dart';
import 'UserCourse.dart';
import 'UserData.dart';

export 'CommentData.dart';
export 'CourseData.dart';
export 'LessonData.dart';
export 'TodoData.dart';
export 'UserCourse.dart';
export 'UserData.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "996d2ada215e41ad4453a22f1f916ec0";
  @override
  List<ModelSchema> modelSchemas = [CommentData.schema, CourseData.schema, LessonData.schema, TodoData.schema, UserCourse.schema, UserData.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
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