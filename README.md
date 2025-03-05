Bright HR Posts

Bright HR Posts is a Flutter application that fetches and displays posts from the JSONPlaceholder API. It implements BLoC state management and provides offline storage using Hive. Users can browse posts, save them for offline access, and remove saved posts.

📌 Features

✅ Fetch posts from JSONPlaceholder API✅ BLoC State Management for handling UI state efficiently✅ Offline storage with Hive to save and retrieve posts✅ Tabbed Navigation for switching between posts and saved posts✅ Reusable UI components for consistent design✅ Modular project structure for maintainability

📂 Project Structure

📦 bright_hr_posts
 ┣ 📂 assets         # Static assets (icons, images, etc.)
 ┣ 📂 common
 ┃ ┗ 📂 entities    # Data models (Post entity)
 ┣ 📂 pages
 ┃ ┗ 📂 home
 ┃   ┣ 📂 bloc      # BLoC implementation (state management)
 ┃   ┣ 📂 widgets   # Reusable widgets (PostTile, etc.)
 ┃   ┣ controller.dart  # Business logic controller
 ┃   ┣ home_screen.dart  # Main home page with tabs
 ┃   ┣ post_list_tab.dart  # Tab for fetching posts
 ┃   ┗ offline_post_tab.dart  # Tab for offline (saved) posts
 ┣ 📜 pubspec.yaml  # Dependencies and assets configuration
 ┗ 📜 main.dart     # App entry point

🚀 Setup & Installation

Prerequisites

Flutter SDK installed (Download Here)

Dart SDK

Android Studio / VS Code (Recommended)

A device/emulator to run the app

Installation Steps

Clone the repository

git clone https://github.com/yourusername/bright_hr_posts.git
cd bright_hr_posts

Install dependencies

flutter pub get

Run the app

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

http → API calls

🔧 Key Components

HomePageController (Centralized Logic)

Manages navigation

Handles saving & removing posts

Updates UI state

Reusable PostTile Widget

Used in both Post List and Saved Post tabs

Displays post details with dynamic actions

Tab Navigation

Uses TabBarView for Posts and Saved Posts tabs

Controlled via TabController