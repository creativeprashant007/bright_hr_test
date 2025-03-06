import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String get title {
    return Intl.message(
      'Flutter Api',
      name: 'title',
      locale: locale.toString(),
    );
  }

  String get technicalTest {
    return Intl.message(
      'Bright Flutter Technical Test',
      name: 'technical_test',
      locale: locale.toString(),
    );
  }

  // Errors
  String get internetNotAvailable {
    return Intl.message(
      'Internet is not available. You can read saved posts only.',
      name: 'internet_not_available',
      locale: locale.toString(),
    );
  }

  String get savedPostNotFound {
    return Intl.message(
      'Post not found in saved posts.',
      name: 'post_not_found_in_saved_posts',
      locale: locale.toString(),
    );
  }

  String get noPostAvailable {
    return Intl.message(
      'No posts available.',
      name: 'no_post_available',
      locale: locale.toString(),
    );
  }

  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong!',
      name: 'something_went_wrong',
      locale: locale.toString(),
    );
  }

  String get errorLoadingComments {
    return Intl.message(
      'Failed to load comments.',
      name: 'error_loading_comments',
      locale: locale.toString(),
    );
  }

  String get errorSavingPost {
    return Intl.message(
      'Failed to save post.',
      name: 'error_saving_post',
      locale: locale.toString(),
    );
  }

  String get failedToLoadPostDetails {
    return Intl.message(
      'Failed to load post details.',
      name: 'failed_to_load_post_details',
      locale: locale.toString(),
    );
  }

  // Labels
  String get saved {
    return Intl.message('Saved', name: 'saved', locale: locale.toString());
  }

  String get save {
    return Intl.message('Save', name: 'save', locale: locale.toString());
  }

  String get posts {
    return Intl.message('Posts', name: 'posts', locale: locale.toString());
  }

  String get savedPosts {
    return Intl.message(
      'Saved Posts',
      name: 'saved_posts',
      locale: locale.toString(),
    );
  }

  String get savePosts {
    return Intl.message(
      "Save Post",
      name: 'save_post',
      locale: locale.toString(),
    );
  }

  String get postDetails {
    return Intl.message(
      "Post Details",
      name: 'post_details',
      locale: locale.toString(),
    );
  }

  String get viewComments {
    return Intl.message(
      "View Comments",
      name: 'view_comments',
      locale: locale.toString(),
    );
  }

  String get comments {
    return Intl.message(
      "Comments",
      name: 'comments',
      locale: locale.toString(),
    );
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}