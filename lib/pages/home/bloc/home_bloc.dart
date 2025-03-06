import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/common/utils/hive/hive_services.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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

    // Load offline posts from Hive
    on<LoadOfflinePostsEvents>((event, emit) async {
      final offlinePosts = await hiveService.getSavedPosts();
      emit(PostsLoadedState(
        selectedIndex: state.selectedIndex,
        posts: state is PostsLoadedState ? (state as PostsLoadedState).posts : [],
        offlinePosts: offlinePosts,
      ));
    });

    // Fetch posts with internet check
    on<FetchPostsEvents>((event, emit) async {
      emit(PostsLoadingState(selectedIndex: state.selectedIndex));

      // Check internet availability
      var connectivityResult = await Connectivity().checkConnectivity();
      bool hasInternet = connectivityResult != ConnectivityResult.none;

      if (!hasInternet) {
        // Load only offline posts if no internet
        final offlinePosts = await hiveService.getSavedPosts();
        emit(PostsLoadedState(
          selectedIndex: state.selectedIndex,
          posts: [],
          offlinePosts: offlinePosts,
          showOfflineMessage: true, // Indicate internet is unavailable
        ));
        return;
      }

      try {
        final posts = await postRepository.fetchPosts();
        final offlinePosts = await hiveService.getSavedPosts();
        emit(PostsLoadedState(
          selectedIndex: state.selectedIndex,
          posts: posts,
          offlinePosts: offlinePosts,
          showOfflineMessage: false,
        ));
      } catch (e) {
        final offlinePosts = await hiveService.getSavedPosts();
        emit(PostsLoadedState(
          selectedIndex: state.selectedIndex,
          posts: [],
          offlinePosts: offlinePosts,
          showOfflineMessage: true, // Show message in case of error
        ));
      }
    });

    // Handle saving a post to Hive
    on<SavePostEvents>((event, emit) async {
      try {
        // Save post to Hive (or your local database)
        await hiveService.savePost(event.post);

        // After saving, fetch updated offline posts
        final offlinePosts = await hiveService.getSavedPosts();
        
        // Update the UI with the saved post
        emit(PostsLoadedState(
          selectedIndex: state.selectedIndex,
          posts: state is PostsLoadedState ? (state as PostsLoadedState).posts : [],
          offlinePosts: offlinePosts,
          showOfflineMessage: false, // No offline message after saving
        ));
      } catch (e) {
        emit(HomeErrorState(
          selectedIndex: state.selectedIndex,
          message: 'Error saving post: $e',
        ));
      }
    });
  }
}
