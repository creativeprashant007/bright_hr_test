
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
      appBar: AppBar(title: const Text("Comments")),
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(comment.body),
                    ),
                  );
                },
              );
            } else if (state is CommentsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: Text("Something went wrong!"));
            }
          },
        ),
      ),
    );
  }
}
