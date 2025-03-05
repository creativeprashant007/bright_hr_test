// API response model
import 'package:bright_hr_posts/common/entities/post.dart';

class PostResponse {
  int? code;
  String? message;
  List<Post>? data;

  PostResponse({this.code, this.message, this.data});

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
    code: json["code"],
    message: json["message"],
    data:
        (json["data"] as List<dynamic>?)
            ?.map((post) => Post.fromJson(post))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.map((post) => post.toJson()).toList(),
  };
}
