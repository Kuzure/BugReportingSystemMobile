import 'package:equatable/equatable.dart';

abstract class BugListEvent extends Equatable {

  const BugListEvent();

  @override
  List<Object> get props => [];
}

class BugListFetchedEvent extends BugListEvent {}

class BugListResetEvent extends BugListEvent {}