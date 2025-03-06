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
                height: 15.h,
                width: 15.w,

                child: Image.asset(AssetStrings.home),
              ),
              text: AppLocalizations.of(context)!.posts,
            ),
            Tab(
              icon: SizedBox(
                height: 15.h,
                width: 15.w,
                child: Image.asset(AssetStrings.heart),
              ),
              text: AppLocalizations.of(context)!.savedPosts,
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
