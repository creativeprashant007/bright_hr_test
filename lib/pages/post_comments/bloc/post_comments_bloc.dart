import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/pages/post_comments/bloc/fetch_comments_events.dart';
import 'package:bright_hr_posts/pages/post_comments/bloc/post_comments_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostApi _repository = PostApi();

  CommentsBloc() : super(CommentsInitial()) {
    on<FetchCommentsEvent>((event, emit) async {
      emit(CommentsLoading());
      try {
        final comments = await _repository.fetchCommentsByPostId(event.postId);
        emit(CommentsLoaded(comments));
      } catch (e) {
        emit(CommentsError("error_loading_comments"));
      }
    });
  }
}
