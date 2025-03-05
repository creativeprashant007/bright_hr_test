import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/common/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize Hive
    // Initialize Hive
    await Hive.initFlutter();

    // Register Hive Adapters (if your Post model is custom)
    Hive.registerAdapter(
      PostAdapter(),
    ); // Ensure you have PostAdapter generated

    // Open a Hive Box (this can also be handled in HiveService)
    await Hive.openBox<Post>(AppConstants.SAVE_POST_HIVE_KEY);
  }
}
