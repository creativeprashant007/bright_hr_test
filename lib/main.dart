import 'package:bright_hr_posts/common/routes/app_routes.dart';
import 'package:bright_hr_posts/common/values/colors.dart';
import 'package:bright_hr_posts/global.dart';
import 'package:bright_hr_posts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bright_hr_posts/cubit/locale_cubit.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()), // Add LocaleCubit
        ...AppRoutes.allProviders(context),
      ],
      child: Builder(
        builder: (context) {
          final locale =
              context.watch<LocaleCubit>().state; // Get the current locale

          return ScreenUtilInit(
            designSize: Size(360, 690), // Set the design size for ScreenUtil
            builder: (context, child) {
              return MaterialApp(
                locale: locale,
                theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.primaryBackground,
                  iconTheme: const IconThemeData(color: AppColors.primaryText),
                  appBarTheme: const AppBarTheme(
                    elevation: 1,
                    backgroundColor: Colors.white,
                  ),
                ),
                title:
                    AppLocalizations.of(context)?.title ??
                    "Flutter API Test", // Use localized title
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en', ''), Locale('es', '')],
                onGenerateRoute: AppRoutes.GenerateRouteSettings,
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
