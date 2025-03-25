import 'package:bright_hr_posts/common/values/asset_strings.dart';
import 'package:bright_hr_posts/common/values/colors.dart';
import 'package:bright_hr_posts/common/widget/app_bar.dart';
import 'package:bright_hr_posts/l10n/app_localizations.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:bright_hr_posts/pages/home/controller.dart';
import 'package:bright_hr_posts/pages/home/widgets/build_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomePageController controller;

  @override
  void initState() {
    super.initState();
    controller = HomePageController(context: context, vsync: this);
    context.read<HomeBloc>().add(
      LoadOfflinePostsEvents(),
    ); // Load offline posts on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        AppLocalizations.of(context)!.title,
        bottom: TabBar(
          unselectedLabelColor: AppColors.primarySecondaryElementText,
          labelColor: AppColors.primaryElement,
          controller: controller.tabController,
          onTap:
              (index) =>
                  context.read<HomeBloc>().add(HomeTabChangedEvents(index)),
          tabs: [
            Tab(
              icon: SizedBox(
                height: 18.h,
                width: 18.w,
                child: Image.asset(AssetStrings.home),
              ),
              text: AppLocalizations.of(context)!.posts,
            ),
            BlocBuilder<HomeBloc, HomeStates>(
              builder: (context, state) {
                int offlinePostCount = 0;
                if (state is PostsLoadedState) {
                  offlinePostCount = state.offlinePosts.length;
                }
                return Tab(
                  icon: Stack(
                    clipBehavior: Clip.none, // Ensures badge is not clipped
                    children: [
                      SizedBox(
                        height: 18.h,
                        width: 18.w,
                        child: Image.asset(AssetStrings.heart),
                      ),
                      if (offlinePostCount > 0)
                        Positioned(
                          bottom: -4, // Moves badge slightly down
                          right: -10, // Moves badge slightly to the right
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ), // Adds a small border
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16.w,
                              minHeight: 16.h,
                            ),
                            child: Text(
                              offlinePostCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  text: AppLocalizations.of(context)!.savedPosts,
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          return TabBarView(
            controller: controller.tabController,
            children: buildPages(controller),
          );
        },
      ),
    );
  }
}
