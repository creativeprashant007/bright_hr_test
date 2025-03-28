import 'package:bright_hr_posts/common/values/asset_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(String title, {PreferredSizeWidget? bottom}) {
  return AppBar(
    bottom: bottom,
    title: Container(
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 18.w,
            height: 18.h,
            child: Image.asset(AssetStrings.menu),
          ),
          SizedBox(width: 30.w),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
