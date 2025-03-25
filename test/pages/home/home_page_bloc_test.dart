import 'package:bright_hr_posts/common/entities/post.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:bright_hr_posts/common/utils/api/post/post_api.dart';
import 'package:bright_hr_posts/common/utils/hive/hive_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mocktail/mocktail.dart';

/// ✅ Mock classes
class MockPostApi extends Mock implements PostApi {}

class MockHiveService extends Mock implements HiveService {}

class MockConnectivity extends Mock implements Connectivity {}

/// ✅ Fake `Post` class implementation
class FakePost extends Fake implements Post {
  @override
  final int id;
  @override
  final String title;
  @override
  final String body;

  FakePost({this.id = 1, this.title = "Test Title", this.body = "Test Body"});
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// ✅ Mocking MethodChannel for connectivity_plus
  const MethodChannel channel = MethodChannel('dev.fluttercommunity.plus/connectivity');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'check') {
        return 'none'; // 🛠️ Mocking no internet connection
      }
      return null;
    });
  });

  late HomeBloc homeBloc;
  late MockPostApi mockPostApi;
  late MockHiveService mockHiveService;
  late MockConnectivity mockConnectivity;

  /// ✅ Fix: Register fallback for `Post`
  setUpAll(() {
    registerFallbackValue(FakePost());
  });

  setUp(() {
    mockPostApi = MockPostApi();
    mockHiveService = MockHiveService();
    mockConnectivity = MockConnectivity();

    // /// ✅ Fix: Returns single `ConnectivityResult`
    // when(() => mockConnectivity.checkConnectivity())
    //     .thenAnswer((_) async => ConnectivityResult.none);

    // /// ✅ Fix: Returns stream of `ConnectivityResult` for `onConnectivityChanged`
    // when(() => mockConnectivity.onConnectivityChanged)
    //     .thenAnswer((_) => Stream.value(ConnectivityResult.none));

    homeBloc = HomeBloc(
      postRepository: mockPostApi,
      hiveService: mockHiveService,
    );
  });

  tearDown(() {
    homeBloc.close();
  });

  test('Initial state should be HomeInitialState', () {
    expect(homeBloc.state, const HomeInitialState(selectedIndex: 0));
  });

  test('Tab change event updates state correctly', () {
    homeBloc.add(HomeTabChangedEvents(1));

    expectLater(
      homeBloc.stream,
      emitsInOrder([
        isA<HomeInitialState>().having(
          (s) => s.selectedIndex,
          'selectedIndex',
          1,
        ),
      ]),
    );
  });

  test('FetchPostsEvents - No internet should load offline posts', () async {
    when(() => mockHiveService.getSavedPosts()).thenAnswer((_) async => []);

    homeBloc.add(FetchPostsEvents());

    await expectLater(
      homeBloc.stream,
      emitsInOrder([
        isA<PostsLoadingState>(),
        isA<PostsLoadedState>().having(
          (s) => s.showOfflineMessage,
          'showOfflineMessage',
          true,
        ),
      ]),
    );
  });

  test('SavePostEvents - should save a post and update state', () async {
    final fakePost = FakePost(); // ✅ Fix: Correct instance of FakePost
    when(() => mockHiveService.savePost(any())).thenAnswer((_) async {});
    when(() => mockHiveService.getSavedPosts()).thenAnswer((_) async => []);

    homeBloc.add(SavePostEvents(fakePost));

    await expectLater(homeBloc.stream, emits(isA<PostsLoadedState>()));
  });
}
