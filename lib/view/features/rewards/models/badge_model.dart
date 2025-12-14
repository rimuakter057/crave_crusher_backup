class BadgeModel {
  final String id;
  final String name;
  final String badgeImage;
  final int day;

  BadgeModel({
    required this.id,
    required this.name,
    required this.badgeImage,
    required this.day,
  });

  // JSON থেকে model তৈরি করা
  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      badgeImage: json['badge_image'] as String,
      day: json['day'] as int,
    );
  }

  // Model কে JSON এ convert করা
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'badge_image': badgeImage,
      'day': day,
    };
  }
}
