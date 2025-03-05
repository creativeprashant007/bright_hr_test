import 'package:bright_hr_posts/pages/home/controller.dart';
import 'package:bright_hr_posts/pages/home/offline_post_tab.dart';
import 'package:bright_hr_posts/pages/home/post_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> buildPages(HomePageController controller) {
  return [
    PostListTab(controller: controller),
    SavedPostsTab(controller: controller),
  ];
}

var homeTabs = [
  Tab(
    icon: SizedBox(
      height: 15.h,
      width: 15.w,
      child: Image.asset("assets/icons/home.png"),
    ),
    text: "Posts",
  ),
  Tab(
    icon: SizedBox(
      height: 15.h,
      width: 15.w,
      child: Image.asset("assets/icons/heart.png"),
    ),
    text: "Saved Posts",
  ),
];
