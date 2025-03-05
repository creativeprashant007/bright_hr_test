import 'package:bright_hr_posts/common/widget/capatilized_text.dart';
import 'package:flutter/material.dart';
import 'package:bright_hr_posts/common/entities/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final bool isSaved;
  final bool isSavedAlready;
  final VoidCallback? onSave;
  final VoidCallback? onRemove;

  const PostTile({
    Key? key,
    required this.post,
    required this.isSaved,
    this.onSave,
    this.onRemove,
    this.isSavedAlready = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: CustomTextWidget(text: post.title, fontSize: 14),
        subtitle: CustomTextWidget(
          text: post.body,
          fontWeight: FontWeight.normal,
        ),
        trailing: isSaved ? _buildDeleteButton() : _buildSaveButton(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: onSave,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child: Text(isSavedAlready ? "Saved" : "Save"),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: onRemove,
    );
  }
}
