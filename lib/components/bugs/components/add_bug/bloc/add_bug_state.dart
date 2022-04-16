import 'package:bugreportingsystem/core/model/api/module_model_response.dart';
import 'package:equatable/equatable.dart';

abstract class AddBugState {
  const AddBugState();
}

abstract class AddBugEquatableState extends Equatable implements AddBugState {
  const AddBugEquatableState();

  @override
  List<Object> get props => [];
}
class AddBugStateSplash extends AddBugEquatableState {}

class AddBugStateWaitingForAnswer extends AddBugEquatableState {}

class AddBugStateInitial extends AddBugEquatableState {}

class AddBugStateUpdate extends AddBugEquatableState {

  final List<ModuleModelResponse> category;
  final int? redmine;
  final int? priority;
  final int? type;
  final String? description;
  final ModuleModelResponse? modelResponse;
  final String? phoneNumber;
  final String? imeiNumber;
  const AddBugStateUpdate( { required this.category, this.redmine,this.priority, this.type, this.description, this.modelResponse,
  this.phoneNumber,this.imeiNumber});

  AddBugStateUpdate copyWith({
    required List<ModuleModelResponse>?category,
  }) {
    return AddBugStateUpdate(
      category: category ?? this.category, redmine: redmine ?? this.redmine,priority: priority ??this.priority,description: description ?? this.description
        ,type: type ?? this.type
    );
  }

  @override
  List<Object> get props => [category,];
}

class AddBugStateError extends AddBugEquatableState {
  final String error;

  const AddBugStateError(this.error);

  @override
  List<Object> get props => [error];
}