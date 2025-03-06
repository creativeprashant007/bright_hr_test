import 'package:bright_hr_posts/pages/home/controller.dart';
import 'package:bright_hr_posts/pages/home/offline_post_tab.dart';
import 'package:bright_hr_posts/pages/home/post_list_tab.dart';
import 'package:flutter/material.dart';


List<Widget> buildPages(HomePageController controller) {
  return [
    PostListTab(controller: controller),
    SavedPostsTab(controller: controller),
  ];
}


