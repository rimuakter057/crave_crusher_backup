class FaqModel {
  String? id;
  String? sId;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  int? v;

  FaqModel({
    this.id,
    this.sId,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      sId: json['_id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "_id": sId,
      "question": question,
      "answer": answer,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}
