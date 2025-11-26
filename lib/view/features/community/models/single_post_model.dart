class SinglePostModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  SinglePostModel({this.success, this.statusCode, this.message, this.data});

  SinglePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Post? post;
  List<Comments>? comments;
  List<Votes>? votes;

  Data({this.post, this.comments, this.votes});

  Data.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['votes'] != null) {
      votes = <Votes>[];
      json['votes'].forEach((v) {
        votes!.add(new Votes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.votes != null) {
      data['votes'] = this.votes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  String? sId;
  AuthorIdDetails? authorId;
  String? content;
  List<String>? postImages;
  int? totalVotes;
  int? totalComments;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Post(
      {this.sId,
        this.authorId,
        this.content,
        this.postImages,
        this.totalVotes,
        this.totalComments,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorId = json['authorId'] != null
        ? new AuthorIdDetails.fromJson(json['authorId'])
        : null;
    content = json['content'];
    postImages = json['post_images'].cast<String>();
    totalVotes = json['totalVotes'];
    totalComments = json['totalComments'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.toJson();
    }
    data['content'] = this.content;
    data['post_images'] = this.postImages;
    data['totalVotes'] = this.totalVotes;
    data['totalComments'] = this.totalComments;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AuthorId {
  String? sId;
  String? fullName;
  String? email;
  Null? profileImage;

  AuthorId({this.sId, this.fullName, this.email, this.profileImage});

  AuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Comments {
  String? sId;
  String? postId;
  AuthorIdDetails? authorId;
  String? commentText;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comments(
      {this.sId,
        this.postId,
        this.authorId,
        this.commentText,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    postId = json['postId'];
    authorId = json['authorId'] != null
        ? new AuthorIdDetails.fromJson(json['authorId'])
        : null;
    commentText = json['commentText'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['postId'] = this.postId;
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.toJson();
    }
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AuthorIdDetails {
  String? sId;
  String? fullName;
  Null? profileImage;

  AuthorIdDetails({this.sId, this.fullName, this.profileImage});

  AuthorIdDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Votes {
  String? sId;
  AuthorIdDetails? userId;
  String? postId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Votes(
      {this.sId,
        this.userId,
        this.postId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Votes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
    json['userId'] != null ? new AuthorIdDetails.fromJson(json['userId']) : null;
    postId = json['postId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['postId'] = this.postId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
