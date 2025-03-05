import 'package:bright_hr_posts/common/entities/comments.dart';
import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:bright_hr_posts/common/utils/api/http_utils.dart';
import 'package:bright_hr_posts/common/values/constants.dart';

class PostApi {
  /// Fetch all posts
  Future<List<Post>> fetchPosts() async {
    var response = await HttpUtils().get(AppConstants.POSTS_API_URL);

    if (response.statusCode == 200) {
      print("response data is:${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  /// Fetch a single post by ID
  Future<Post> fetchPostById(int postId) async {
    var response = await HttpUtils().get(
      '${AppConstants.POSTS_API_URL}/$postId',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      return Post.fromJson(data);
    } else {
      throw Exception("Failed to load post");
    }
  }

  /// Fetch comments for a specific post
  Future<List<Comment>> fetchCommentsByPostId(int postId) async {
    var response = await HttpUtils().get(
      '${AppConstants.POSTS_API_URL}/$postId/comments',
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load comments");
    }
  }
}
