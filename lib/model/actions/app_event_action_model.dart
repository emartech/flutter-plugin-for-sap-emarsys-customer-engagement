import 'package:equatable/equatable.dart';

import '../action_model.dart';

class AppEventActionModel extends ActionModel with EquatableMixin {
  final String name;

  final Map<String, Object>? payload;

  AppEventActionModel(
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
