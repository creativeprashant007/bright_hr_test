import 'package:bright_hr_posts/common/widget/app_bar.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:bright_hr_posts/pages/home/widgets/build_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen to TabController and update BLoC when swiped
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<HomeBloc>().add(
          HomeTabChangedEvents(_tabController.index),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        "Bright Hr Posts",
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            context.read<HomeBloc>().add(HomeTabChangedEvents(index));
          },
          tabs: homeTabs,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          return TabBarView(controller: _tabController, children: buildPage());
        },
      ),
    );
  }
}
