class FaqModel {
  String? id;
  String? sId;
  String? question;
  String? answer;

  bool isExpanded;

  FaqModel({
    this.id,
    this.sId,
    this.question,
    this.answer,

    this.isExpanded = false,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      sId: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "_id": sId, "question": question, "answer": answer};
  }
}
