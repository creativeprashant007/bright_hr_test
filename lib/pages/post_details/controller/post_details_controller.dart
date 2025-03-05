import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/common/values/constants.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_bloc.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class PostDetailsController {
  final BuildContext context;
  late int postId;
  bool isSavedPost = false;

  PostDetailsController(this.context);

  void initializeArguments() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      postId = args['post_id'] as int? ?? -1;
      isSavedPost = args['is_saved'] as bool? ?? false;
    } else {
      postId = -1;
      isSavedPost = false;
    }
    _fetchPostDetails();
  }

  Future<void> _fetchPostDetails() async {
    final box = await Hive.openBox<Post>(AppConstants.SAVE_POST_HIVE_KEY);
    final isSaved = box.containsKey(postId);

    if (isSaved) {
      final post = box.get(postId);
      if (post != null) {
        context.read<PostDetailsBloc>().add(FetchSavedPostDetailsEvent(postId, post));
      }
    } else {
      context.read<PostDetailsBloc>().add(FetchPostDetailsEvent(postId));
    }
  }

  void savePost(Post post) {
    context.read<PostDetailsBloc>().add(SavePostEvent(post));
  }
}
