import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(activeTab: TabTypes.unknown, title: ''));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeTabChangedEvent) {
      yield _mapTabIndexChangedToState(event, state);
    }
    else if (event is HomeTitleChangedEvent) {
      yield _mapTabTitleChangedToState(event, state);
    }
  }

  HomeState _mapTabIndexChangedToState(HomeTabChangedEvent event, HomeState state) {
    return state.copyWith(
        activeTab: event.activeType
    );
  }

  HomeState _mapTabTitleChangedToState(HomeTitleChangedEvent event, HomeState state) {
    return state.copyWith(
        title: event.title
    );
  }
}