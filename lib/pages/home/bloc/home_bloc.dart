import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/common/utils/hive/hive_services.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final PostApi postRepository;
  final HiveService hiveService;

  HomeBloc({required this.postRepository, required this.hiveService})
    : super(const HomeInitialState(selectedIndex: 0)) {
    
    // Handling tab change
    on<HomeTabChangedEvents>((event, emit) {
      emit(state.copyWith(selectedIndex: event.tabIndex));
    });

    // Fetch posts from API and load saved posts
    on<FetchPostsEvents>((event, emit) async {
      emit(PostsLoadingState(selectedIndex: state.selectedIndex));
      try {
        final posts = await postRepository.fetchPosts();
        final offlinePosts = await hiveService.getSavedPosts(); // Load saved posts

        emit(
          PostsLoadedState(
            selectedIndex: state.selectedIndex,
            posts: posts,
            offlinePosts: offlinePosts,
          ),
        );
      } catch (e) {
        emit(
          HomeErrorState(
            selectedIndex: state.selectedIndex,
            message: e.toString(),
          ),
        );
      }
    });

    // Load offline posts from Hive
    on<LoadOfflinePostsEvents>((event, emit) async {
      final offlinePosts = await hiveService.getSavedPosts();
      if (state is PostsLoadedState) {
        emit((state as PostsLoadedState).copyWith(offlinePosts: offlinePosts));
      }
    });

    // Save a post to Hive
    on<SavePostEvents>((event, emit) async {
      await hiveService.savePost(event.post);
      final offlinePosts = await hiveService.getSavedPosts(); // Refresh offline posts
      if (state is PostsLoadedState) {
        emit((state as PostsLoadedState).copyWith(offlinePosts: offlinePosts));
      }
    });

    // Remove a post from Hive
    on<RemovePostEvents>((event, emit) async {
      await hiveService.removePost(event.postId);
      final offlinePosts = await hiveService.getSavedPosts(); // Refresh offline posts
      if (state is PostsLoadedState) {
        emit((state as PostsLoadedState).copyWith(offlinePosts: offlinePosts));
      }
    });
  }
}
