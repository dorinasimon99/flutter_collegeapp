import 'dart:io';

import 'package:amplify_flutter/amplify.dart';

class StorageRepository {
  Future<String> uploadFile(File file) async {
    try {
      final fileName = DateTime.now().toIso8601String() + 'avatar';
      final result = await Amplify.Storage.uploadFile(
          local: file,
          key: fileName + '.jpg'
      );
      return result.key;
    } catch(e){
      throw (e);
    }
  }

  Future<String?> getUrlForFile(String? imageKey) async {
    if(imageKey != null){
      try {
        final result = await Amplify.Storage.getUrl(key: imageKey);
        return result.url;
      } catch(e){
        throw e;
      }
    }
  }
}