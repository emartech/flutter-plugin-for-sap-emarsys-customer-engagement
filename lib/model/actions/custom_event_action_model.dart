import 'package:equatable/equatable.dart';

import '../action_model.dart';

class CustomEventActionModel extends ActionModel with EquatableMixin {
  String name;

  Map<String, Object>? payload;

  CustomEventActionModel(
      {required String id,
      required String title,
      required String type,
      required this.name,
      this.payload})
      : super(id, title, type);

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
