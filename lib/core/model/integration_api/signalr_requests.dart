import 'package:json_annotation/json_annotation.dart';

part 'signalr_requests.g.dart';

abstract class SignalrRequest { }

@JsonSerializable()
class SignalrScaleValueRequest extends SignalrRequest {
  final String nodeId;
  final String registrationNumber;

  SignalrScaleValueRequest(this.nodeId, this.registrationNumber);

  factory SignalrScaleValueRequest.fromJson(Map<String, dynamic> json) => _$SignalrScaleValueRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignalrScaleValueRequestToJson(this);
}