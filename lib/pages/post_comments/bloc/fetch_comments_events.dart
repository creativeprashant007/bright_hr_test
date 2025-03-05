import 'package:equatable/equatable.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
  @override
  List<Object> get props => [];
}

class FetchCommentsEvent extends CommentsEvent {
  final int postId;

  const FetchCommentsEvent(this.postId);

  @override
  List<Object> get props => [postId];
}
