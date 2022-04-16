import 'package:bugreportingsystem/core/model/api/report.dart';
import 'package:equatable/equatable.dart';

abstract class BugListState extends Equatable {
  const BugListState();

  @override
  List<Object> get props => [];
}

class BugListInitial extends BugListState {}

class BugListError extends BugListState {
  final String error;

  const BugListError(this.error);

  @override
  List<Object> get props => [error];
}

class BugListSuccess extends BugListState {
  final List<Report> bugs;
  final bool hasReachedMax;

  const BugListSuccess({
    required this.bugs,
    required this.hasReachedMax,
  });

  BugListSuccess copyWith({
    List<Report>? bugs,
    bool? hasReachedMax,
    Report? activeReport,
  }) {
    return BugListSuccess(
      bugs: bugs ?? this.bugs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [bugs, hasReachedMax];
}
