import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  const HomeEvents();
  @override
  List<Object> get props => [];
}

class HomeTabChangedEvents extends HomeEvents {
  final int tabIndex;
  const HomeTabChangedEvents(this.tabIndex);
  @override
  List<Object> get props => [tabIndex];
}
