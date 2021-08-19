import 'package:equatable/equatable.dart';
import 'action_model.dart';

class Message extends Equatable {
  final String id;
  final String campaignId;
  final String? collapseId;
  final String title;
  final String body;
  final String? imageUrl;
  final int receivedAt;
  final int? updatedAt;
  final int? expiresAt;
  final List<String>? tags;
  final Map<String, String>? properties;
  final List<ActionModel>? actions;

  Message({
    required this.id,
    required this.campaignId,
    this.collapseId,
    required this.title,
    required this.body,
    this.imageUrl,
    required this.receivedAt,
    this.updatedAt,
    this.expiresAt,
    this.tags,
    this.properties,
    this.actions,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        campaignId,
        collapseId,
        title,
        body,
        imageUrl,
        receivedAt,
        updatedAt,
        expiresAt,
        tags,
        properties,
        actions
      ];
}
