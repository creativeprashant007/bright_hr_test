import 'package:bright_hr_posts/common/values/colors.dart';
import 'package:bright_hr_posts/l10n/app_localizations.dart';
import 'package:bright_hr_posts/pages/post_comments/post_comments_page.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_bloc.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_states.dart';
import 'package:bright_hr_posts/pages/post_details/controller/post_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late PostDetailsController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = PostDetailsController(context);
    _controller.initializeArguments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.postDetails)),
      body: BlocBuilder<PostDetailsBloc, PostDetailsState>(
        builder: (context, state) {
          if (state is PostDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostDetailsLoaded) {
            final post = state.post;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.body,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Save button with dynamic styling
                  ElevatedButton(
                    onPressed:
                        state.isSaved ? null : () => _controller.savePost(post),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          state.isSaved
                              ? AppColors.primarySecondaryElementText
                              : AppColors
                                  .primaryElement, // Blue when not saved, grey when saved
                      foregroundColor:
                          state.isSaved
                              ? AppColors.primaryText
                              : AppColors
                                  .primaryElementText, // White text when not saved
                    ),
                    child: Text(
                      state.isSaved
                          ? AppLocalizations.of(context)!.savedPosts
                          : AppLocalizations.of(context)!.savePosts,
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (!_controller.isSavedPost)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    CommentsScreen(postId: _controller.postId),
                          ),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.viewComments),
                    ),
                ],
              ),
            );
          } else if (state is PostDetailsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.primaryElementBg),
              ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.somethingWentWrong),
            );
          }
        },
      ),
    );
  }
}
