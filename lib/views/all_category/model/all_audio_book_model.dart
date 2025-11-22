class AllAudioBookModel {
  final bool success;
  final String message;
  final Data data;

  AllAudioBookModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllAudioBookModel.fromJson(Map<String, dynamic> json) => AllAudioBookModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  final List<AudioBook> audioBooks;

  Data({
    required this.audioBooks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    audioBooks: List<AudioBook>.from(json["audioBooks"].map((x) => AudioBook.fromJson(x))),
  );

}

class AudioBook {
  final String id;
  final String bookCover;
  final String bookName;
  final String synopsis;
  final Category category;
  final String categoryName;
  final String audioFile;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AudioBook({
    required this.id,
    required this.bookCover,
    required this.bookName,
    required this.synopsis,
    required this.category,
    required this.categoryName,
    required this.audioFile,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AudioBook.fromJson(Map<String, dynamic> json) => AudioBook(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
    category: Category.fromJson(json["category"]),
    categoryName: json["categoryName"],
    audioFile: json["audioFile"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
  );

}
