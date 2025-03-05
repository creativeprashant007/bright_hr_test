import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  const HomeEvents();
  @override
  List<Object> get props => [];
}

class HomeTabChangedEvents extends HomeEvents {
  final int tabIndex;
  const HomeTabChangedEvents(this.tabIndex);
  @override
  List<Object> get props => [tabIndex];
}

// Fetch posts from API
class FetchPostsEvents extends HomeEvents {}

// Load offline posts from Hive
class LoadOfflinePostsEvents extends HomeEvents {}

// Save a post to Hive
class SavePostEvents extends HomeEvents {
  final Post post;
  const SavePostEvents(this.post);
  @override
  List<Object> get props => [post];
}

// Remove a post from Hive
class RemovePostEvents extends HomeEvents {
  final int postId;
  const RemovePostEvents(this.postId);
  @override
  List<Object> get props => [postId];
}
