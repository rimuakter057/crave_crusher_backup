class NotificationModel {

  final String? title;
  final String? message;


  NotificationModel({ this.title, this.message, });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(

      title: json['title'],
      message: json['message'],

    );
  }
}
