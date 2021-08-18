import 'package:equatable/equatable.dart';

import 'package:emarsys_sdk/model/action_model.dart';

import '../action_model.dart';

class OpenExternalUrlActionModel extends Equatable implements ActionModel {
  @override
  String id;

  @override
  String title;

  @override
  String type;

  String url;

  OpenExternalUrlActionModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.url});

  @override
  List<Object> get props => [id, title, type, url];

  @override
  bool? get stringify => true;
}
