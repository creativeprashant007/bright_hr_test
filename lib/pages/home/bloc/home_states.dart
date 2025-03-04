import 'package:equatable/equatable.dart';

class HomeStates extends Equatable {
  final int selectedIndex;
  const HomeStates({required this.selectedIndex});
  @override
  List<Object> get props => [selectedIndex];
}
