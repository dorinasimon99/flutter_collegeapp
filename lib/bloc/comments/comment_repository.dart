
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class CommentsRepository {

  Future<List<CommentData>> getComments(String teacherName, String courseCode) async {
    try {
      var items = await Amplify.DataStore.query(CommentData.classType,
          where: CommentData.TEACHERNAME.eq(teacherName).and(CommentData.COURSECODE.eq(courseCode)));
      return items;
    } catch (e) {
      throw e;
    }
  }


  Future<void> createComment(CommentData comment) async {
    try {
      await Amplify.DataStore.save(comment);
    } catch (e) {
      throw e;
    }
  }
}