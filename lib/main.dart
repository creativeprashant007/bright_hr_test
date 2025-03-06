import 'package:bright_hr_posts/common/routes/app_routes.dart';
import 'package:bright_hr_posts/common/values/colors.dart';
import 'package:bright_hr_posts/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppRoutes.allProviders(context)],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            builder: EasyLoading.init(),
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryBackground,
              iconTheme: const IconThemeData(color: AppColors.primaryText),
              appBarTheme: const AppBarTheme(
                elevation: 1,
                backgroundColor: Colors.white,
              ),
            ),
            title: 'Flutter Demo',

            onGenerateRoute: AppRoutes.GenerateRouteSettings,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
