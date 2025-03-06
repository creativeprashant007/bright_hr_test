import 'package:bright_hr_posts/pages/home/controller.dart';
import 'package:bright_hr_posts/pages/home/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';

class PostListTab extends StatelessWidget {
  final HomePageController controller;

  const PostListTab({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state is PostsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoadedState) {
          final posts = state.posts;
          final savedPostIds = state.offlinePosts.map((p) => p.id).toSet();

          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshPosts();
            },
            child: Column(
              children: [
                if (state.showOfflineMessage) // Show message if no internet
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.red.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: const [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Internet is not available. You can read saved posts only.",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final isSaved = savedPostIds.contains(post.id);

                      return GestureDetector(
                        onTap:
                            () => controller.navigateToDetailsPage(post, false),
                        child: PostTile(
                          post: post,
                          isSaved: false,
                          isSavedAlready: isSaved,
                          onSave:
                              isSaved ? null : () => controller.savePost(post),
                          onRemove:
                              isSaved
                                  ? () => controller.removePost(post.id)
                                  : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No posts available"));
        }
      },
    );
  }
}
