class NotificationModel {
  final String? id;
  final String? title;
  final String? message;

  NotificationModel({this.id, this.title, this.message});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      title: json['title'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'title': title, 'message': message};
  }
}
