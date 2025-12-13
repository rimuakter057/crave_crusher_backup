class BattleDetailsModel {
  Battle? battle;
  List<BattleLogs>? battleLogs;

  BattleDetailsModel({this.battle, this.battleLogs});

  BattleDetailsModel.fromJson(Map<String, dynamic> json) {
    battle =
    json['battle'] != null ? new Battle.fromJson(json['battle']) : null;
    if (json['battleLogs'] != null) {
      battleLogs = <BattleLogs>[];
      json['battleLogs'].forEach((v) {
        battleLogs!.add(new BattleLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.battle != null) {
      data['battle'] = this.battle!.toJson();
    }
    if (this.battleLogs != null) {
      data['battleLogs'] = this.battleLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Battle {
  String? id;
  String? userId;
  String? addictionType;
  String? addictionLevel;
  int? battleLength;
  int? day;
  bool? sendReminder;
  String? battleReason;
  int? battleProgress;
  String? battleStatus;
  int? totalCrave;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Battle(
      {this.id,
        this.userId,
        this.addictionType,
        this.addictionLevel,
        this.battleLength,
        this.day,
        this.sendReminder,
        this.battleReason,
        this.battleProgress,
        this.battleStatus,
        this.totalCrave,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Battle.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    addictionType = json['addictionType'];
    addictionLevel = json['addictionLevel'];
    battleLength = json['battleLength'];
    day = json['day'];
    sendReminder = json['sendReminder'];
    battleReason = json['battleReason'];
    battleProgress = json['battleProgress'];
    battleStatus = json['battleStatus'];
    totalCrave = json['totalCrave'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userId'] = this.userId;
    data['addictionType'] = this.addictionType;
    data['addictionLevel'] = this.addictionLevel;
    data['battleLength'] = this.battleLength;
    data['day'] = this.day;
    data['sendReminder'] = this.sendReminder;
    data['battleReason'] = this.battleReason;
    data['battleProgress'] = this.battleProgress;
    data['battleStatus'] = this.battleStatus;
    data['totalCrave'] = this.totalCrave;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class BattleLogs {
  String? sId;
  String? battleId;
  int? day;
  String? status;
  int? iV;
  String? createdAt;
  String? updatedAt;

  BattleLogs(
      {this.sId,
        this.battleId,
        this.day,
        this.status,
        this.iV,
        this.createdAt,
        this.updatedAt});

  BattleLogs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    battleId = json['battleId'];
    day = json['day'];
    status = json['status'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['battleId'] = this.battleId;
    data['day'] = this.day;
    data['status'] = this.status;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
