import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bright_hr_posts/pages/home/homepage.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_bloc.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:mocktail/mocktail.dart';

// Mock Bloc
class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeBloc mockHomeBloc;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<HomeBloc>.value(
        value: mockHomeBloc,
        child: const HomePage(),
      ),
    );
  }

  testWidgets('Check if HomePage UI renders correctly', (
    WidgetTester tester,
  ) async {
    when(
      () => mockHomeBloc.state,
    ).thenReturn(const HomeInitialState(selectedIndex: 0));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("Posts"), findsOneWidget);
    expect(find.text("Saved Posts"), findsOneWidget);
  });

  testWidgets('Tab switch works correctly', (WidgetTester tester) async {
    when(
      () => mockHomeBloc.state,
    ).thenReturn(const HomeInitialState(selectedIndex: 0));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("Posts"), findsOneWidget);

    await tester.tap(find.text("Saved Posts"));
    await tester.pump();

    verify(() => mockHomeBloc.add(HomeTabChangedEvents(1))).called(1);
  });
}
