class NotificationChannel {
  static const int IMPORTANCE_DEFAULT = 3;
  static const int IMPORTANCE_HIGH = 4;
  static const int IMPORTANCE_LOW = 2;
  static const int IMPORTANCE_MAX = 5;
  static const int IMPORTANCE_MIN = 1;
  static const int IMPORTANCE_NONE = 0;
  static const int IMPORTANCE_UNSPECIFIED = -1000;
  String id;
  String name;
  String description;
  int importance;
  NotificationChannel({
    required this.id,
    required this.name,
    required this.description,
    required this.importance,
  });

  NotificationChannel copyWith({
    String? id,
    String? name,
    String? description,
    int? importance,
  }) {
    return NotificationChannel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      importance: importance ?? this.importance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'importance': importance,
    };
  }

  factory NotificationChannel.fromMap(Map<String, dynamic> map) {
    return NotificationChannel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      importance: map['importance'],
    );
  }

  @override
  String toString() {
    return 'NotificationChannel(id: $id, name: $name, description: $description, importance: $importance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationChannel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.importance == importance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        importance.hashCode;
  }
}
