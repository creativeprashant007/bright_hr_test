import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/pages/home/controller.dart';
import 'package:bright_hr_posts/pages/home/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';

class SavedPostsTab extends StatelessWidget {
  final HomePageController controller;

  const SavedPostsTab({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state is PostsLoadedState && state.offlinePosts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.offlinePosts.length,
            itemBuilder: (context, index) {
              final Post post = state.offlinePosts[index];

              return GestureDetector(
                onTap: () => controller.navigateToDetailsPage(post, true),
                child: PostTile(
                  post: post,
                  isSaved: true,
                  onRemove: () => controller.removePost(post.id),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("No saved posts found"));
        }
      },
    );
  }
}
