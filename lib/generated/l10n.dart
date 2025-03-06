// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Api`
  String get title {
    return Intl.message(
      'Flutter Api',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Bright Flutter Technical Test`
  String get technical_test {
    return Intl.message(
      'Bright Flutter Technical Test',
      name: 'technical_test',
      desc: '',
      args: [],
    );
  }

  /// `Internet is not available. You can read saved posts only.`
  String get internet_not_available {
    return Intl.message(
      'Internet is not available. You can read saved posts only.',
      name: 'internet_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Post not found in saved posts.`
  String get post_not_found_in_saved_posts {
    return Intl.message(
      'Post not found in saved posts.',
      name: 'post_not_found_in_saved_posts',
      desc: '',
      args: [],
    );
  }

  /// `No posts available.`
  String get no_post_available {
    return Intl.message(
      'No posts available.',
      name: 'no_post_available',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong!',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load comments.`
  String get error_loading_comments {
    return Intl.message(
      'Failed to load comments.',
      name: 'error_loading_comments',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save post.`
  String get error_saving_post {
    return Intl.message(
      'Failed to save post.',
      name: 'error_saving_post',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load post details.`
  String get failed_to_load_post_details {
    return Intl.message(
      'Failed to load post details.',
      name: 'failed_to_load_post_details',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get posts {
    return Intl.message(
      'Posts',
      name: 'posts',
      desc: '',
      args: [],
    );
  }

  /// `Saved Posts`
  String get saved_posts {
    return Intl.message(
      'Saved Posts',
      name: 'saved_posts',
      desc: '',
      args: [],
    );
  }

  /// `Save Post`
  String get save_post {
    return Intl.message(
      'Save Post',
      name: 'save_post',
      desc: '',
      args: [],
    );
  }

  /// `Post Details`
  String get post_details {
    return Intl.message(
      'Post Details',
      name: 'post_details',
      desc: '',
      args: [],
    );
  }

  /// `View Comments`
  String get view_comments {
    return Intl.message(
      'View Comments',
      name: 'view_comments',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
