📌 Features

✅ Fetch posts from JSONPlaceholder API
✅ BLoC State Management for handling UI state efficiently
✅ Offline storage with Hive to save and retrieve posts
✅ Tabbed Navigation for switching between posts and saved posts
✅ Reusable UI components for consistent design
✅ Modular project structure for maintainability

🚀 Setup & Installation

Prerequisites

Flutter SDK installed (Download Here)
Dart SDK
Android Studio / VS Code (Recommended)
A device/emulator to run the app
Installation Steps

Clone the repository:


git clone https://github.com/yourusername/bright_hr_posts.git
cd bright_hr_posts
Install dependencies:


flutter pub get
Run the app:


flutter run
🏗️ BLoC State Management Overview

The app follows the BLoC (Business Logic Component) pattern to manage state efficiently. It separates UI from business logic, making it scalable and maintainable.

Events: Define user actions (e.g., FetchPostsEvents, SavePostEvents).
States: Define UI states (e.g., PostsLoadingState, PostsLoadedState).
Bloc: Processes events and updates state accordingly.
BlocBuilder: Listens to state changes and rebuilds UI.
BLoC Example:


// Event: Fetch posts
class FetchPostsEvents extends HomeEvents {}

// State: Loaded posts
class PostsLoadedState extends HomeStates {
  final List<Post> posts;
  final List<Post> offlinePosts;
  PostsLoadedState({required this.posts, required this.offlinePosts});
}
📜 Dependencies Used

flutter_bloc → State management
hive & hive_flutter → Offline storage
flutter_screenutil → Responsive UI
dio → API calls
🔧 Key Components

HomePageController (Centralized Logic)
Manages navigation, handles saving & removing posts, and updates UI state.

Reusable PostTile Widget
Used in both the Post List and Saved Post tabs to display post details with dynamic actions.

Tab Navigation
Uses TabBarView for Posts and Saved Posts tabs, controlled via TabController.

🧪 Widget Testing
The app includes widget tests to ensure that the UI behaves as expected. Widget tests help simulate user interactions, validate UI rendering, and ensure smooth navigation.

Test Functionality:
Tab Navigation: Test the switching between "Posts" and "Saved Posts" tabs.
UI Validation: Verify the display of posts and saved posts, and handle empty states.
Interaction: Simulate taps on tab labels and validate state changes.
How to Run Widget Tests:
Create a test file: Widget tests are stored in the test directory of your project. For example, home_page_test.dart.

Write the test: In the test file, you simulate user interactions using the flutter_test package.

Example:

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bright_hr_posts/pages/home/homepage.dart'; // Import your widget

void main() {
  testWidgets('Toggles between tabs on tap', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(const MyApp());

    // Ensure initial tab is "Posts"
    expect(find.text('Posts'), findsOneWidget);
    expect(find.text('Saved Posts'), findsOneWidget);

    // Tap on "Saved Posts" tab and verify the content
    await tester.tap(find.text('Saved Posts'));
    await tester.pumpAndSettle();
    expect(find.text('No saved posts found'), findsOneWidget);

    // Switch back to "Posts" tab and verify the content
    await tester.tap(find.text('Posts'));
    await tester.pumpAndSettle();
    expect(find.text('Posts'), findsOneWidget);
  });
}
Run the tests:

Run the tests using:


flutter test
This will execute the widget tests and show the results in your terminal.

