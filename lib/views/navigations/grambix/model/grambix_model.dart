class GrambixModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  GrambixModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GrambixModel.fromJson(Map<String, dynamic> json) => GrambixModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final List<ContinueIng>? continueReading;
  final List<ContinueIng>? continueListening;

  Data({
    this.continueReading,
    this.continueListening,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    continueReading: json["continueReading"] == null ? [] : List<ContinueIng>.from(json["continueReading"]!.map((x) => ContinueIng.fromJson(x))),
    continueListening: json["continueListening"] == null ? [] : List<ContinueIng>.from(json["continueListening"]!.map((x) => ContinueIng.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "continueReading": continueReading == null ? [] : List<dynamic>.from(continueReading!.map((x) => x.toJson())),
    "continueListening": continueListening == null ? [] : List<dynamic>.from(continueListening!.map((x) => x.toJson())),
  };
}

class ContinueIng {
  final String? id;
  final String? userId;
  final ContentId? contentId;
  final String? contentType;
  final dynamic progress;
  final int? readingProgress;
  final int? listeningProgress;
  final int? currentPage;
  final int? totalPages;
  final int? currentTime;
  final int? totalDuration;
  final bool? isCompleted;
  final bool? bookmarked;
  final DateTime? startedAt;
  final DateTime? lastReadAt;
  final DateTime? lastListenAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? contentModel;

  ContinueIng({
    this.id,
    this.userId,
    this.contentId,
    this.contentType,
    this.progress,
    this.readingProgress,
    this.listeningProgress,
    this.currentPage,
    this.totalPages,
    this.currentTime,
    this.totalDuration,
    this.isCompleted,
    this.bookmarked,
    this.startedAt,
    this.lastReadAt,
    this.lastListenAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.contentModel,
  });

  factory ContinueIng.fromJson(Map<String, dynamic> json) => ContinueIng(
    id: json["_id"],
    userId: json["userId"],
    contentId: json["contentId"] == null ? null : ContentId.fromJson(json["contentId"]),
    contentType: json["contentType"],
    progress: json["progress"],
    readingProgress: json["readingProgress"],
    listeningProgress: json["listeningProgress"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    currentTime: json["currentTime"],
    totalDuration: json["totalDuration"],
    isCompleted: json["isCompleted"],
    bookmarked: json["bookmarked"],
    startedAt: json["startedAt"] == null ? null : DateTime.parse(json["startedAt"]),
    lastReadAt: json["lastReadAt"] == null ? null : DateTime.parse(json["lastReadAt"]),
    lastListenAt: json["lastListenAt"] == null ? null : DateTime.parse(json["lastListenAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    contentModel: json["contentModel"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "contentId": contentId?.toJson(),
    "contentType": contentType,
    "progress": progress,
    "readingProgress": readingProgress,
    "listeningProgress": listeningProgress,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "currentTime": currentTime,
    "totalDuration": totalDuration,
    "isCompleted": isCompleted,
    "bookmarked": bookmarked,
    "startedAt": startedAt?.toIso8601String(),
    "lastReadAt": lastReadAt?.toIso8601String(),
    "lastListenAt": lastListenAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "contentModel": contentModel,
  };
}

class ContentId {
  final String? id;
  final String? bookCover;
  final String? bookName;
  final String? synopsis;
  final String? categoryName;
  final bool? isAudioBook;
  final bool? isEbook;
  final bool? isBook;

  ContentId({
    this.id,
    this.bookCover,
    this.bookName,
    this.synopsis,
    this.categoryName,
    this.isAudioBook,
    this.isEbook,
    this.isBook,
  });

  factory ContentId.fromJson(Map<String, dynamic> json) => ContentId(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
    categoryName: json["categoryName"],
    isAudioBook: json["isAudioBook"],
    isEbook: json["isEbook"],
    isBook: json["isBook"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookCover": bookCover,
    "bookName": bookName,
    "synopsis": synopsis,
    "categoryName": categoryName,
    "isAudioBook": isAudioBook,
    "isEbook": isEbook,
    "isBook": isBook,
  };
}
