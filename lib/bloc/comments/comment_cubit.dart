import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/models/CommentData.dart';
import 'package:flutter_collegeapp/bloc/comments/comment_repository.dart';

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

class CreateCommentSuccess extends CommentsState {
  final CommentData comment;

  CreateCommentSuccess({required this.comment});
}

class CreateCommentFailure extends CommentsState {
  final Object exception;

  CreateCommentFailure({required this.exception});
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
    try{
      await _commentsRepo.createComment(comment);
      emit(CreateCommentSuccess(comment: comment));
    } catch(e) {
      emit(CreateCommentFailure(exception: e));
    }
  }
}