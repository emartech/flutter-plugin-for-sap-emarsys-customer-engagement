import 'package:equatable/equatable.dart';

import '../action_model.dart';

class CustomEventActionModel extends Equatable implements ActionModel {
  @override
  String id;

  @override
  String title;

  @override
  String type;

  String name;

  Map<String, Object>? payload;

  CustomEventActionModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.name,
      this.payload});

  @override
  List<Object?> get props {
    return [
      id,
      title,
      type,
      name,
      payload,
    ];
  }
}
