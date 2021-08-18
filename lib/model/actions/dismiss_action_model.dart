import 'package:equatable/equatable.dart';

import '../action_model.dart';

class DismissActionModel extends Equatable implements ActionModel {
  @override
  String id;

  @override
  String title;

  @override
  String type;

  DismissActionModel(
      {required this.id, required this.title, required this.type});

  @override
  List<Object> get props => [id, title, type];

  @override
  bool? get stringify => true;
}
