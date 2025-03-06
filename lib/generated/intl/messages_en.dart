// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "comments": MessageLookupByLibrary.simpleMessage("Comments"),
        "error_loading_comments":
            MessageLookupByLibrary.simpleMessage("Failed to load comments."),
        "error_saving_post":
            MessageLookupByLibrary.simpleMessage("Failed to save post."),
        "failed_to_load_post_details": MessageLookupByLibrary.simpleMessage(
            "Failed to load post details."),
        "internet_not_available": MessageLookupByLibrary.simpleMessage(
            "Internet is not available. You can read saved posts only."),
        "no_post_available":
            MessageLookupByLibrary.simpleMessage("No posts available."),
        "post_details": MessageLookupByLibrary.simpleMessage("Post Details"),
        "post_not_found_in_saved_posts": MessageLookupByLibrary.simpleMessage(
            "Post not found in saved posts."),
        "posts": MessageLookupByLibrary.simpleMessage("Posts"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "save_post": MessageLookupByLibrary.simpleMessage("Save Post"),
        "saved": MessageLookupByLibrary.simpleMessage("Saved"),
        "saved_posts": MessageLookupByLibrary.simpleMessage("Saved Posts"),
        "something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong!"),
        "technical_test": MessageLookupByLibrary.simpleMessage(
            "Bright Flutter Technical Test"),
        "title": MessageLookupByLibrary.simpleMessage("Flutter Api"),
        "view_comments": MessageLookupByLibrary.simpleMessage("View Comments")
      };
}
