// To parse this JSON data, do
//
//     final grambixModel = grambixModelFromJson(jsonString);

import 'dart:convert';

GrambixModel grambixModelFromJson(String str) => GrambixModel.fromJson(json.decode(str));

String grambixModelToJson(GrambixModel data) => json.encode(data.toJson());

class GrambixModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  GrambixModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GrambixModel.fromJson(Map<String, dynamic> json) => GrambixModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final List<ContinueIng> continueReading;
  final List<ContinueIng> continueListening;

  Data({
    required this.continueReading,
    required this.continueListening,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    continueReading: List<ContinueIng>.from(json["continueReading"].map((x) => ContinueIng.fromJson(x))),
    continueListening: List<ContinueIng>.from(json["continueListening"].map((x) => ContinueIng.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "continueReading": List<dynamic>.from(continueReading.map((x) => x.toJson())),
    "continueListening": List<dynamic>.from(continueListening.map((x) => x.toJson())),
  };
}

class ContinueIng {
  final String id;
  final String userId;
  final String contentId;
  final String contentType;
  final int progress;
  final int currentPage;
  final int totalPages;
  final int currentTime;
  final int totalDuration;
  final bool isCompleted;
  final bool bookmarked;
  final DateTime startedAt;
  final DateTime lastReadAt;
  final DateTime lastListenAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ContinueIng({
    required this.id,
    required this.userId,
    required this.contentId,
    required this.contentType,
    required this.progress,
    required this.currentPage,
    required this.totalPages,
    required this.currentTime,
    required this.totalDuration,
    required this.isCompleted,
    required this.bookmarked,
    required this.startedAt,
    required this.lastReadAt,
    required this.lastListenAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ContinueIng.fromJson(Map<String, dynamic> json) => ContinueIng(
    id: json["_id"],
    userId: json["userId"],
    contentId: json["contentId"],
    contentType: json["contentType"],
    progress: json["progress"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    currentTime: json["currentTime"],
    totalDuration: json["totalDuration"],
    isCompleted: json["isCompleted"],
    bookmarked: json["bookmarked"],
    startedAt: DateTime.parse(json["startedAt"]),
    lastReadAt: DateTime.parse(json["lastReadAt"]),
    lastListenAt: DateTime.parse(json["lastListenAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "contentId": contentId,
    "contentType": contentType,
    "progress": progress,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "currentTime": currentTime,
    "totalDuration": totalDuration,
    "isCompleted": isCompleted,
    "bookmarked": bookmarked,
    "startedAt": startedAt.toIso8601String(),
    "lastReadAt": lastReadAt.toIso8601String(),
    "lastListenAt": lastListenAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
