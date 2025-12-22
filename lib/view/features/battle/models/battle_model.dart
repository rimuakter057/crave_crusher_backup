class BattleModel {
  final String? id;
  final String? addictionType;
  final String? addictionLevel;
  final int? battleLength;
  final bool? sendReminder;
  final String? battleReason;
  final int? battleProgress;
  final String? battleStatus;
  final int? day;
  final String? todayStatus; //next added

  final String? currentDayStatus;
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
    this.currentDayStatus,
    this.todayStatus, //next added
  });

  factory BattleModel.fromJson(Map<String, dynamic> json) => BattleModel(
    id: json['_id'],
    addictionType: json["addictionType"],
    addictionLevel: json["addictionLevel"],
    battleLength: json["battleLength"],
    sendReminder: json["sendReminder"],
    battleReason: json["battleReason"],
    battleProgress: json["battleProgress"],
    battleStatus: json["battleStatus"],
    day: json["day"],
    currentDayStatus: json["currentDayStatus"],
    todayStatus: json["todayStatus"], //next added
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
    "day": day,
    "currentDayStatus": currentDayStatus,
    "todayStatus": todayStatus,
  };
}
