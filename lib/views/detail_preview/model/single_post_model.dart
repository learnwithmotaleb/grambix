class SinglePostModel {
  final bool success;
  final Data data;

  SinglePostModel({required this.success, required this.data});

  factory SinglePostModel.fromJson(Map<String, dynamic> json) =>
      SinglePostModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String id;
  final String bookCover;
  final String bookName;
  final String synopsis;
  final String category;
  final String categoryName;
  final String audioFile;
  final String pdfFile;
  final int v;
  final int totalPages;
  final dynamic duration;
  final bool? isSaved;

  Data({
    required this.id,
    required this.bookCover,
    required this.bookName,
    required this.synopsis,
    required this.category,
    required this.categoryName,
    required this.audioFile,
    required this.pdfFile,
    required this.v,
    required this.totalPages,
    required this.duration,
     this.isSaved,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
    category: json["category"],
    categoryName: json["categoryName"],
    audioFile: json["audioFile"] ?? '',
    pdfFile: json["pdfFile"] ?? '',
    v: json["__v"],
    totalPages: json["totalPages"] ?? 0,
    duration: json["duration"] ?? 0,
    isSaved: json["isSaved"],
  );
}
