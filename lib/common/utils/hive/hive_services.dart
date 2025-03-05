import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/common/values/constants.dart';
import 'package:hive/hive.dart';

class HiveService {
  static const String boxName = AppConstants.SAVE_POST_HIVE_KEY;

  // Open Hive Box
  Future<Box<Post>> openBox() async {
    return await Hive.openBox<Post>(boxName);
  }

  // Save a post to Hive
  Future<void> savePost(Post post) async {
    final box = await openBox();
    await box.put(post.id, post);
  }

  // Remove a post from Hive
  Future<void> removePost(int postId) async {
    final box = await openBox();
    await box.delete(postId);
  }

  // Get all saved posts
  Future<List<Post>> getSavedPosts() async {
    final box = await openBox();
    return box.values.toList();
  }

  // Check if a post is saved offline
  Future<bool> isPostSaved(int postId) async {
    final box = await openBox();
    return box.containsKey(postId);
  }

  // Close Hive Box
  Future<void> closeBox() async {
    final box = await openBox();
    await box.close();
  }
}
