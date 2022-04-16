
import 'package:bugreportingsystem/core/repository/bug_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bug_list_event.dart';
import 'bug_list_state.dart';

class BugListBloc extends Bloc<BugListEvent,BugListState> {
  static const int _PAGE_SIZE = 50;

  final BugRepository _bugRepository;

  BugListBloc({
    required BugRepository? bugRepository
  })  : assert(bugRepository != null),
        _bugRepository = bugRepository!,
        super(BugListInitial());

  @override
  Stream<BugListState> mapEventToState(BugListEvent event) async* {
    try {

      if (event is BugListResetEvent) {
        yield BugListInitial();
        final bugs = await _bugRepository.getBugs(
            startIndex: 0,
            limit: _PAGE_SIZE
        );

        yield BugListSuccess(
            bugs: bugs,
            hasReachedMax: bugs.length < _PAGE_SIZE
        );
      }
      if (event is BugListFetchedEvent ) {

          final bugs = await _bugRepository.getBugs(
              startIndex: 0,
              limit: _PAGE_SIZE
          );

          yield BugListSuccess(
              bugs: bugs,
              hasReachedMax: bugs.length < _PAGE_SIZE
          );

        /*else if (currentState is BugListSuccess) {
          final bugs = await _bugRepository.getBugs(
              dateFrom,
              dateTo,
              startIndex: currentState.bugs.length,
              limit: _PAGE_SIZE
          );

          yield bugs!.isEmpty
              ? currentState.copyWith(hasReachedMax: true, activeReport: null)
              : BugListSuccess(
              bugs: currentState.bugs + bugs,
              hasReachedMax: false
          );
        }*/
      }
    } catch (ex) {
      var str = ex.toString();
      if(str.substring(str.length-8, str.length-3)=='30000')
        str = "Twoja próba połączyć z siecią przekroczyła 30 sekund sprawdż status internetu";
      yield BugListError(str.toString());
    }
  }

}