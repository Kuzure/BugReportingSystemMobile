abstract class SignalrMessage {}

class SignalrNewGateEntryMessage extends SignalrMessage {}

class SignalrRequestWeightMessage extends SignalrMessage {}

class SignalrWeightCompleteMessage extends SignalrMessage {}

class SignalrScaleValueMessage extends SignalrMessage {
  final int value;
  final bool isStablized;
  final String error;
  final bool isError;

  SignalrScaleValueMessage(this.value, this.isStablized, this.error, this.isError);
}