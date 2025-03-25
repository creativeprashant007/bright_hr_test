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
      emit(
        PostsLoadedState(
          selectedIndex: state.selectedIndex,
          posts:
              state is PostsLoadedState
                  ? (state as PostsLoadedState).posts
                  : [],
          offlinePosts: offlinePosts,
        ),
      );
    });

    // Fetch posts with internet check
    on<FetchPostsEvents>((event, emit) async {
      emit(PostsLoadingState(selectedIndex: state.selectedIndex));

      var connectivityResult = await Connectivity().checkConnectivity();
      bool hasInternet = connectivityResult != ConnectivityResult.none;

      if (!hasInternet) {
        final offlinePosts = await hiveService.getSavedPosts();
        emit(
          PostsLoadedState(
            selectedIndex: state.selectedIndex,
            posts: [],
            offlinePosts: offlinePosts,
            showOfflineMessage: true,
          ),
        );
        return;
      }

      try {
        final posts = await postRepository.fetchPosts();
        final offlinePosts = await hiveService.getSavedPosts();
        emit(
          PostsLoadedState(
            selectedIndex: state.selectedIndex,
            posts: posts,
            offlinePosts: offlinePosts,
            showOfflineMessage: false,
          ),
        );
      } catch (e) {
        final offlinePosts = await hiveService.getSavedPosts();
        emit(
          PostsLoadedState(
            selectedIndex: state.selectedIndex,
            posts: [],
            offlinePosts: offlinePosts,
            showOfflineMessage: true,
          ),
        );
      }
    });

    // Handle saving a post to Hive
    on<SavePostEvents>((event, emit) async {
      try {
        await hiveService.savePost(event.post);
        final offlinePosts = await hiveService.getSavedPosts();
        emit(
          PostsLoadedState(
            selectedIndex: state.selectedIndex,
            posts:
                state is PostsLoadedState
                    ? (state as PostsLoadedState).posts
                    : [],
            offlinePosts: offlinePosts,
            showOfflineMessage: false,
          ),
        );
      } catch (e) {
        emit(
          HomeErrorState(
            selectedIndex: state.selectedIndex,
            message: 'something_went_wrong',
          ),
        );
      }
    });

    // Handle removing a post from Hive
    on<RemovePostEvents>((event, emit) async {
      try {
        await hiveService.removePost(event.postId);
        final offlinePosts = await hiveService.getSavedPosts();
        emit(
          PostsLoadedState(
            selectedIndex: state.selectedIndex,
            posts:
                state is PostsLoadedState
                    ? (state as PostsLoadedState).posts
                    : [],
            offlinePosts: offlinePosts,
            showOfflineMessage: false,
          ),
        );
      } catch (e) {
        emit(
          HomeErrorState(
            selectedIndex: state.selectedIndex,
            message: 'something_went_wrong',
          ),
        );
      }
    });
  }
}
