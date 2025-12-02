class PostModel {
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  PostModel({this.success, this.statusCode, this.message, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['success'] = success;
    dataMap['statusCode'] = statusCode;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class Data {
  String? sId;
  Author? author;
  String? content;
  List<String>? postImages;
  int? totalVotes;
  int? totalComments;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Comments>? comments;
  List<Votes>? votes;

  Data(
      {this.sId,
        this.author,
        this.content,
        this.postImages,
        this.totalVotes,
        this.totalComments,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.comments,
        this.votes});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['authorId'] != null ? Author.fromJson(json['authorId']) : null;
    content = json['content'];
    postImages = json['post_images']?.cast<String>();
    totalVotes = json['totalVotes'];
    totalComments = json['totalComments'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    if (json['votes'] != null) {
      votes = <Votes>[];
      json['votes'].forEach((v) {
        votes!.add(Votes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['_id'] = sId;
    if (author != null) dataMap['authorId'] = author!.toJson();
    dataMap['content'] = content;
    dataMap['post_images'] = postImages;
    dataMap['totalVotes'] = totalVotes;
    dataMap['totalComments'] = totalComments;
    dataMap['isDeleted'] = isDeleted;
    dataMap['createdAt'] = createdAt;
    dataMap['updatedAt'] = updatedAt;
    dataMap['__v'] = iV;
    if (comments != null) {
      dataMap['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (votes != null) {
      dataMap['votes'] = votes!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

// Author used in posts
class Author {
  String? sId;
  String? fullName;
  String? email;
  String? profileImage;

  Author({this.sId, this.fullName, this.email, this.profileImage});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['_id'] = sId;
    dataMap['fullName'] = fullName;
    dataMap['email'] = email;
    dataMap['profileImage'] = profileImage;
    return dataMap;
  }
}

// Author used in comments and votes
class User {
  String? sId;
  String? fullName;
  String? profileImage;

  User({this.sId, this.fullName, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['_id'] = sId;
    dataMap['fullName'] = fullName;
    dataMap['profileImage'] = profileImage;
    return dataMap;
  }
}

class Comments {
  String? sId;
  String? postId;
  User? author;
  String? commentText;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comments(
      {this.sId,
        this.postId,
        this.author,
        this.commentText,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    postId = json['postId'];
    author = json['authorId'] != null ? User.fromJson(json['authorId']) : null;
    commentText = json['commentText'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['_id'] = sId;
    dataMap['postId'] = postId;
    if (author != null) dataMap['authorId'] = author!.toJson();
    dataMap['commentText'] = commentText;
    dataMap['createdAt'] = createdAt;
    dataMap['updatedAt'] = updatedAt;
    dataMap['__v'] = iV;
    return dataMap;
  }
}

class Votes {
  String? sId;
  User? user;
  String? postId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Votes({this.sId, this.user, this.postId, this.createdAt, this.updatedAt, this.iV});

  Votes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['userId'] != null ? User.fromJson(json['userId']) : null;
    postId = json['postId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['_id'] = sId;
    if (user != null) dataMap['userId'] = user!.toJson();
    dataMap['postId'] = postId;
    dataMap['createdAt'] = createdAt;
    dataMap['updatedAt'] = updatedAt;
    dataMap['__v'] = iV;
    return dataMap;
  }
}
