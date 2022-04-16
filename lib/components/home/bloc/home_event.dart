import 'home_state.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeTabChangedEvent extends HomeEvent {
  final TabTypes activeType;

  const HomeTabChangedEvent(this.activeType);
}

class HomeTitleChangedEvent extends HomeTabChangedEvent {
  final String title;

  const HomeTitleChangedEvent(this.title, TabTypes activeType) : super(activeType);
}