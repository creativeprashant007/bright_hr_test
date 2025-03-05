import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostDetailsEvent extends Equatable {
  const PostDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchPostDetailsEvent extends PostDetailsEvent {
  final int postId;

  const FetchPostDetailsEvent(this.postId);

  @override
  List<Object> get props => [postId];
}

class FetchSavedPostDetailsEvent extends PostDetailsEvent {
  final int postId;
  final Post post;

  const FetchSavedPostDetailsEvent(this.postId, this.post);

  @override
  List<Object> get props => [postId, post];
}

class SavePostEvent extends PostDetailsEvent {
  final Post post;

  const SavePostEvent(this.post);

  @override
  List<Object> get props => [post];
}
