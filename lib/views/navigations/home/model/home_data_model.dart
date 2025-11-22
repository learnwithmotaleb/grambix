class HomeDataModel {
  final bool success;
  final Data data;

  HomeDataModel({required this.success, required this.data});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  final List<NewRelease> recommended;
  final List<NewRelease> newReleases;
  final List<NewRelease> trending;

  Data({
    required this.recommended,
    required this.newReleases,
    required this.trending,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    recommended: List<NewRelease>.from(
      json["recommended"].map((x) => NewRelease.fromJson(x)),
    ),
    newReleases: List<NewRelease>.from(
      json["newReleases"].map((x) => NewRelease.fromJson(x)),
    ),
    trending: List<NewRelease>.from(
      json["trending"].map((x) => NewRelease.fromJson(x)),
    ),
  );
}

class NewRelease {
  final String id;
  final String bookCover;
  final String bookName;
  final String synopsis;
  final String categoryName;
  final bool isAudioBook;
  final bool isEbook;
  final bool isBook;

  NewRelease({
    required this.id,
    required this.bookCover,
    required this.bookName,
    required this.synopsis,
    required this.categoryName,
    required this.isAudioBook,
    required this.isEbook,
    required this.isBook,
  });

  factory NewRelease.fromJson(Map<String, dynamic> json) => NewRelease(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
    categoryName: json["categoryName"] ?? '',
    isAudioBook: json["isAudioBook"],
    isEbook: json["isEbook"],
    isBook: json["isBook"],
  );
}
