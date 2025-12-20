class BattleDetailsModel {
  Battle? battle;
  List<BattleLogs>? battleLogs;
  final Monster? monster;

  BattleDetailsModel({this.battle, this.battleLogs, this.monster});

  BattleDetailsModel.fromJson(Map<String, dynamic> json)
    : monster =
          json["monster"] != null ? Monster.fromJson(json["monster"]) : null {
    battle = json['battle'] != null ? Battle.fromJson(json['battle']) : null;

    if (json['battleLogs'] != null) {
      battleLogs = <BattleLogs>[];
      json['battleLogs'].forEach((v) {
        battleLogs!.add(BattleLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (battle != null) {
      data['battle'] = battle!.toJson();
    }
    if (battleLogs != null) {
      data['battleLogs'] = battleLogs!.map((v) => v.toJson()).toList();
    }
    if (monster != null) {
      data['monster'] = monster!.toJson();
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

  Battle({
    this.id,
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
    this.iV,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userId'] = userId;
    data['addictionType'] = addictionType;
    data['addictionLevel'] = addictionLevel;
    data['battleLength'] = battleLength;
    data['day'] = day;
    data['sendReminder'] = sendReminder;
    data['battleReason'] = battleReason;
    data['battleProgress'] = battleProgress;
    data['battleStatus'] = battleStatus;
    data['totalCrave'] = totalCrave;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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

  BattleLogs({
    this.sId,
    this.battleId,
    this.day,
    this.status,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['battleId'] = battleId;
    data['day'] = day;
    data['status'] = status;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Monster {
  final String? monsterImage;

  Monster({this.monsterImage});

  factory Monster.fromJson(Map<String, dynamic> json) {
    return Monster(monsterImage: json["monster_image"]);
  }

  Map<String, dynamic> toJson() => {"monster_image": monsterImage};
}
