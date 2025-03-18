import 'package:equatable/equatable.dart';

import 'package:emarsys_sdk/model/action_model.dart';

class OpenExternalUrlActionModel extends ActionModel with EquatableMixin {
  final String url;

  OpenExternalUrlActionModel(
      {required String id,
      required String title,
      required String type,
      required this.url})
      : super(id, title, type);

  @override
  List<Object> get props => [id, title, type, url];

  @override
  bool? get stringify => true;
}
