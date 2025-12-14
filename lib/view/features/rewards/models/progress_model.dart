class BadgeProgressModel {
  final String id;
  final String userId;
  final int currentProgress;
  final int craveCount;
  final CurrentBadge currentBadge;

  BadgeProgressModel({
    required this.id,
    required this.userId,
    required this.currentProgress,
    required this.craveCount,
    required this.currentBadge,
  });

  factory BadgeProgressModel.fromJson(Map<String, dynamic> json) {
    return BadgeProgressModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      currentProgress: json['currentProgress'] ?? 0,
      craveCount: json['craveCount'] ?? 0,
      currentBadge: CurrentBadge.fromJson(json['currentBadgeId'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'currentProgress': currentProgress,
      'craveCount': craveCount,
      'currentBadgeId': currentBadge.toJson(),
    };
  }
}

class CurrentBadge {
  final String name;
  final String badgeImage;
  final int day;

  CurrentBadge({
    required this.name,
    required this.badgeImage,
    required this.day,
  });

  factory CurrentBadge.fromJson(Map<String, dynamic> json) {
    return CurrentBadge(
      name: json['name'] ?? '',
      badgeImage: json['badge_image'] ?? '',
      day: json['day'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'badge_image': badgeImage, 'day': day};
  }
}
