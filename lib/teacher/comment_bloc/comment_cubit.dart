import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/models/CommentData.dart';
import 'package:flutter_collegeapp/teacher/comment_bloc/comment_repository.dart';

abstract class CommentsState {}

class LoadingComments extends CommentsState {}

class ListCommentsSuccess extends CommentsState {
  final List<CommentData> comments;

  ListCommentsSuccess({required this.comments});
}

class ListCommentsFailure extends CommentsState {
  final Object exception;

  ListCommentsFailure({required this.exception});
}

class CommentsCubit extends Cubit<CommentsState> {
  final _commentsRepo = CommentsRepository();

  CommentsCubit() : super(LoadingComments());

  void getComments(String teacherName, String courseName) async {
    if (state is ListCommentsSuccess == false) {
      emit(LoadingComments());
    }

    try {
      final comments = await _commentsRepo.getComments(teacherName, courseName);
      emit(ListCommentsSuccess(comments: comments));
    } catch (e) {
      emit(ListCommentsFailure(exception: e));
    }
  }

  void createComment(CommentData comment) async {
    await _commentsRepo.createComment(comment);
  }

  void updateComment(CommentData comment) async {
    await _commentsRepo.updateComment(comment);
    getComments(comment.teachername, comment.coursename);
  }
}