import 'package:flutter_bloc/flutter_bloc.dart';

import 'alert_event.dart';
import 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {

  AlertBloc() : super(AlertState(null, null, false));


  @override
  Stream<AlertState> mapEventToState(AlertEvent event) async* {
    yield AlertState(event.title, event.message, event.isError);
  }
}