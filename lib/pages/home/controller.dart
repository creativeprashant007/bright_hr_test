import 'package:bright_hr_posts/common/routes/route_names.dart';
import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageController {
  final BuildContext context;
  late TabController tabController;

  HomePageController({required this.context, required TickerProvider vsync}) {
    tabController = TabController(length: 2, vsync: vsync);
    _initialize();
  }

  void _initialize() {
    // Load offline posts first
    context.read<HomeBloc>().add(LoadOfflinePostsEvents());

    // Then fetch from API
    context.read<HomeBloc>().add(FetchPostsEvents());

    // Listen for tab changes
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        context.read<HomeBloc>().add(HomeTabChangedEvents(tabController.index));
      }
    });
  }

  void navigateToDetailsPage(Post post, bool isSaved) async {
    await Navigator.pushNamed(
      context,
      RouteNames.POST_DETAILS_PAGE,
      arguments: {'post_id': post.id, 'is_saved': isSaved},
    );

    // Reload saved posts after returning
    context.read<HomeBloc>().add(LoadOfflinePostsEvents());
  }

  void savePost(Post post) {
    context.read<HomeBloc>().add(SavePostEvents(post));
  }

  void removePost(int postId) {
    context.read<HomeBloc>().add(RemovePostEvents(postId));
  }

  Future<void> refreshPosts() async {
    context.read<HomeBloc>().add(FetchPostsEvents());
  }
}
