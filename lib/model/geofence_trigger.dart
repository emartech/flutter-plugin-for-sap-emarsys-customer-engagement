import 'package:equatable/equatable.dart';

class GeofenceTrigger extends Equatable {
  final String id;
  final String type;
  final int loiteringDelay;
  final Map<String, dynamic>? action;

  GeofenceTrigger(
      {required this.id,
      required this.type,
      required this.loiteringDelay,
      required this.action});

  @override
  List<Object?> get props => [id, type, loiteringDelay, action];
}
