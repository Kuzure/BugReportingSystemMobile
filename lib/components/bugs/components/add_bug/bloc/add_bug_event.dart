import 'package:bugreportingsystem/core/model/api/module_model_response.dart';
import 'package:equatable/equatable.dart';

abstract class AddBugEvent extends Equatable {
  const AddBugEvent();

  @override
  List<Object> get props => [];
}

class AddBugWaitingForEvent extends AddBugEvent{}

class AddBugTryEvent extends AddBugEvent{}

class
AddBugValueChangedEvent extends AddBugEvent {
  final List<ModuleModelResponse> category;
  final int? priority;
  final int? type;
  final String? description;
  final ModuleModelResponse? modelResponse;
  final String? phoneNumber;
  final String? imei;
  const AddBugValueChangedEvent( { required this.category,this.priority, this.type, this.description, this.modelResponse,this.phoneNumber,
  this.imei});


  @override
  List<Object> get props => [category];
}

class AddBugErrorEvent extends AddBugEvent {
  final String message;

  const AddBugErrorEvent(this.message);

  @override
  List<Object> get props => [message];
}