import 'package:bright_hr_posts/common/values/colors.dart';
import 'package:bright_hr_posts/l10n/app_localizations.dart';
import 'package:bright_hr_posts/pages/post_comments/bloc/fetch_comments_events.dart';
import 'package:bright_hr_posts/pages/post_comments/bloc/post_comments_bloc.dart';
import 'package:bright_hr_posts/pages/post_comments/bloc/post_comments_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  final int postId;

  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.comments)),
      body: BlocProvider(
        create: (context) => CommentsBloc()..add(FetchCommentsEvent(postId)),
        child: BlocBuilder<CommentsBloc, CommentsState>(
          builder: (context, state) {
            if (state is CommentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommentsLoaded) {
              return ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        comment.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      subtitle: Text(
                        comment.body,
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is CommentsError) {
              return Center(
                child: Text(
                  AppLocalizations.of(
                    context,
                  )!.somethingWentWrong, // Localized error message
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
      ),
    );
  }
}
