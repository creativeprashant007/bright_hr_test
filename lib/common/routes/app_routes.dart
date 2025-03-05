import 'package:bright_hr_posts/common/routes/route_names.dart';
import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/common/utils/hive/hive_services.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/homepage.dart';
import 'package:bright_hr_posts/pages/post_details/bloc/post_details_bloc.dart';
import 'package:bright_hr_posts/pages/post_details/post_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: RouteNames.INITIAL,
        page: HomePage(),
        bloc: BlocProvider(
          create:
              (_) => HomeBloc(
                postRepository: PostApi(),
                hiveService: HiveService(),
              ),
        ),
      ),
      PageEntity(
        route: RouteNames.POST_DETAILS_PAGE,
        page: PostDetailsScreen(),
        bloc: BlocProvider(create: (_) => PostDetailsBloc()),
      ),
    ];
  }

  static List<dynamic> allProviders(BuildContext context) {
    List<dynamic> allBlocProviders = [];
    for (var bloc in routes()) {
      allBlocProviders.add(bloc.bloc);
    }
    return allBlocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(builder: (_) => HomePage(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
