import 'dart:io';
import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/common/utils/hive/hive_services.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for dependencies
class MockPostApi extends Mock implements PostApi {}
class MockHiveService extends Mock implements HiveService {}

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Directly provide the mocked directory path instead of using PathProvider
    final mockDirectory = Directory('/mock/path');
    
    // Initialize Hive with the mocked directory
    Hive.init(mockDirectory.path);
  });

  testWidgets('Toggles between tabs on tap', (WidgetTester tester) async {
    // Create mock instances of the dependencies
    final mockPostApi = MockPostApi();
    final mockHiveService = MockHiveService();

    // Mocking the behavior of PostApi and HiveService
    when(() => mockPostApi.fetchPosts()).thenAnswer((_) async => []); // Return empty posts for testing
    when(() => mockHiveService.getSavedPosts()).thenAnswer((_) async => []); // Return empty saved posts

    // Create an instance of HomeBloc with mocked dependencies
    final homeBloc = HomeBloc(postRepository: mockPostApi, hiveService: mockHiveService);

    // Build the widget with a BuildContext to initialize ScreenUtil
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            // Initialize ScreenUtil in the context
            ScreenUtil.init(
              context,
              designSize: const Size(375, 812),
            );

            return BlocProvider<HomeBloc>.value(
              value: homeBloc,
              child: const HomePage(),
            );
          },
        ),
      ),
    );

    // Ensure the first tab (Post List) is displayed
    expect(find.text("Posts"), findsOneWidget);
    expect(find.text("Saved Posts"), findsOneWidget);

    // Tap on the "Saved Posts" tab
    await tester.tap(find.text("Saved Posts"));
    await tester.pumpAndSettle();

    // Add a delay to stay on the "Saved Posts" tab for 3 seconds
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Check if the tab has switched correctly
    expect(find.text("No saved posts found"), findsOneWidget);

    // Switch back to "Posts" tab
    await tester.tap(find.text("Posts"));
    await tester.pumpAndSettle();

    // Add a delay to stay on the "Posts" tab for 3 seconds
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verify that it switched back correctly
    expect(find.text("Posts"), findsOneWidget);
  });
}
