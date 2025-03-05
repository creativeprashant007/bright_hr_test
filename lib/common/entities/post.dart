import 'package:hive/hive.dart';

part 'post.g.dart'; // This file will be generated

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int userId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'], // Added userId mapping
      title: json['title'],
      body: json['body'],
    );
  }
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
