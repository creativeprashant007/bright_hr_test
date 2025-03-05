import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {
  final int selectedIndex;
  const HomeStates({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];

  HomeStates copyWith({int? selectedIndex}) {
    return HomeInitialState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}

// Initial State
class HomeInitialState extends HomeStates {
  const HomeInitialState({required int selectedIndex}) : super(selectedIndex: selectedIndex);
}

// State for Tab Change
class HomeTabChangedState extends HomeStates {
  const HomeTabChangedState({required int selectedIndex}) : super(selectedIndex: selectedIndex);
}

// Loading State (When fetching posts)
class PostsLoadingState extends HomeStates {
  const PostsLoadingState({required int selectedIndex}) : super(selectedIndex: selectedIndex);
}

// Successfully Loaded Posts
class PostsLoadedState extends HomeStates {
  final List<Post> posts;
  final List<Post> offlinePosts; // Include saved posts

  const PostsLoadedState({required int selectedIndex, required this.posts, required this.offlinePosts}) 
      : super(selectedIndex: selectedIndex);

  @override
  List<Object> get props => [selectedIndex, posts, offlinePosts];

  @override
  HomeStates copyWith({int? selectedIndex, List<Post>? posts, List<Post>? offlinePosts}) {
    return PostsLoadedState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      posts: posts ?? this.posts,
      offlinePosts: offlinePosts ?? this.offlinePosts,
    );
  }
}

// Post Successfully Saved
class PostSavedState extends HomeStates {
  final List<Post> offlinePosts;
  const PostSavedState({required int selectedIndex, required this.offlinePosts}) 
      : super(selectedIndex: selectedIndex);

  @override
  List<Object> get props => [selectedIndex, offlinePosts];
}

// Post Successfully Removed
class PostRemovedState extends HomeStates {
  final List<Post> offlinePosts;
  const PostRemovedState({required int selectedIndex, required this.offlinePosts}) 
      : super(selectedIndex: selectedIndex);

  @override
  List<Object> get props => [selectedIndex, offlinePosts];
}

// Error State
class HomeErrorState extends HomeStates {
  final String message;
  const HomeErrorState({required int selectedIndex, required this.message}) 
      : super(selectedIndex: selectedIndex);

  @override
  List<Object> get props => [selectedIndex, message];

  @override
  HomeStates copyWith({int? selectedIndex, String? message}) {
    return HomeErrorState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      message: message ?? this.message,
    );
  }
}
