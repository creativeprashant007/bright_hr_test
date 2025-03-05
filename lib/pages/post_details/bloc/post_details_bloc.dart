import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/common/values/constants.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_events.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final PostApi postApi = PostApi();

  PostDetailsBloc() : super(PostDetailsInitial()) {
    on<FetchPostDetailsEvent>((event, emit) async {
      emit(PostDetailsLoading());
      try {
        final post = await postApi.fetchPostById(event.postId);
        final comments = await postApi.fetchCommentsByPostId(event.postId);
        
        final box = await Hive.openBox<Post>(AppConstants.SAVE_POST_HIVE_KEY);
        final isSaved = box.containsKey(event.postId);

        emit(PostDetailsLoaded(post: post, comments: comments, isSaved: isSaved));
      } catch (e) {
        emit(PostDetailsError(message: "Failed to load post details: ${e.toString()}"));
      }
    });

    on<FetchSavedPostDetailsEvent>((event, emit) async {
      emit(PostDetailsLoading());
      try {
        final box = await Hive.openBox<Post>(AppConstants.SAVE_POST_HIVE_KEY);
        final savedPost = box.get(event.postId);

        if (savedPost != null) {
          emit(PostDetailsLoaded(post: savedPost, comments: [], isSaved: true));
        } else {
          emit(PostDetailsError(message: "Post not found in saved posts"));
        }
      } catch (e) {
        emit(PostDetailsError(message: "Failed to load saved post: ${e.toString()}"));
      }
    });

    on<SavePostEvent>((event, emit) async {
      try {
        final box = await Hive.openBox<Post>(AppConstants.SAVE_POST_HIVE_KEY);
        await box.put(event.post.id, event.post);

        emit(PostDetailsLoaded(post: event.post, comments: [], isSaved: true));
      } catch (e) {
        emit(PostDetailsError(message: "Failed to save post: ${e.toString()}"));
      }
    });
  }
}
