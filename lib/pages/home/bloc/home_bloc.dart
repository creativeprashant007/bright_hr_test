import 'package:bright_hr_posts/pages/home/bloc/home_events.dart';
import 'package:bright_hr_posts/pages/home/bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc() : super(HomeStates(selectedIndex: 0)) {
    on<HomeTabChangedEvents>((events, emit) {
      emit(HomeStates(selectedIndex: state.selectedIndex));
    });
  }
}
