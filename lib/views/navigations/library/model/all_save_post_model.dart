class AllSavePostModel {
  final bool success;
  final List<Datum> data;

  AllSavePostModel({required this.success, required this.data});

  factory AllSavePostModel.fromJson(Map<String, dynamic> json) =>
      AllSavePostModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  final String id;
  final String bookCover;
  final String bookName;
  final String synopsis;
  final String category;
  final String categoryName;
  final String audioFile;
  final List<String> tags;
  final bool isSaved;
  final bool isAudioBook;
  final bool isEbook;
  final bool isBook;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Datum({
    required this.id,
    required this.bookCover,
    required this.bookName,
    required this.synopsis,
    required this.category,
    required this.categoryName,
    required this.audioFile,
    required this.tags,
    required this.isSaved,
    required this.isAudioBook,
    required this.isEbook,
    required this.isBook,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
    category: json["category"],
    categoryName: json["categoryName"],
    audioFile: json["audioFile"] ?? '',
    tags: List<String>.from(json["tags"].map((x) => x)),
    isSaved: json["isSaved"],
    isAudioBook: json["isAudioBook"],
    isEbook: json["isEbook"],
    isBook: json["isBook"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}
