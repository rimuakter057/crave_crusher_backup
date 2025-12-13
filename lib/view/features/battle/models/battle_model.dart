class BattleModel {
  final String?id;
  final String? addictionType;
  final String? addictionLevel;
  final int? battleLength;
  final bool? sendReminder;
  final String? battleReason;
  final int?  battleProgress;
  final String? battleStatus;
  final int? day;

  BattleModel({
    this.id,
    this.addictionType,
    this.addictionLevel,
    this.battleLength,
    this.sendReminder,
    this.battleReason,
    this.battleProgress,
    this.battleStatus,
    this.day,
  });

  factory BattleModel.fromJson(Map<String, dynamic> json) =>
      BattleModel(
        id: json['_id'],
        addictionType: json["addictionType"],
        addictionLevel: json["addictionLevel"],
        battleLength: json["battleLength"],
        sendReminder: json["sendReminder"],
        battleReason: json["battleReason"],
        battleProgress: json["battleProgress"],
        battleStatus: json["battleStatus"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
    '_id': id,
    "addictionType": addictionType,
    "addictionLevel": addictionLevel,
    "battleLength": battleLength,
    "sendReminder": sendReminder,
    "battleReason": battleReason,
    "battleProgress": battleProgress,
    "battleStatus": battleStatus,
    "day":day
  };
}
