import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> buildPage() {
  List<Widget> _widget = [
    Center(child: Text("Posts")),
    Center(child: Text("Saved Posts")),
  ];
  return _widget;
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
