import 'package:bright_hr_posts/common/entities/comments.dart';
import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostDetailsState extends Equatable {
  const PostDetailsState();
  
  @override
  List<Object> get props => [];
}

class PostDetailsInitial extends PostDetailsState {}

class PostDetailsLoading extends PostDetailsState {}

class PostDetailsLoaded extends PostDetailsState {
  final Post post;
  final List<Comment> comments;
  final bool isSaved;

  const PostDetailsLoaded({required this.post, required this.comments, required this.isSaved});

  @override
  List<Object> get props => [post, comments, isSaved];
}

class PostDetailsError extends PostDetailsState {
  final String message;

  const PostDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
