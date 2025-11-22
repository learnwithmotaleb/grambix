class CategoryPreviewModel {
  final bool success;
  final Data data;

  CategoryPreviewModel({required this.success, required this.data});

  factory CategoryPreviewModel.fromJson(Map<String, dynamic> json) =>
      CategoryPreviewModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<BookData> books;
  final Pagination pagination;

  Data({required this.books, required this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    books: List<BookData>.from(json["books"].map((x) => BookData.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );
}

class BookData {
  final String id;
  final String bookCover;
  final String bookName;
  final String synopsis;

  BookData({
    required this.id,
    required this.bookCover,
    required this.bookName,
    required this.synopsis,
  });

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
  );
}

class Pagination {
  final int total;
  final int totalAudioBooks;
  final int totalEbooks;
  final int page;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  Pagination({
    required this.total,
    required this.totalAudioBooks,
    required this.totalEbooks,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    totalAudioBooks: json["totalAudioBooks"],
    totalEbooks: json["totalEbooks"],
    page: json["page"],
    totalPages: json["totalPages"],
    hasNextPage: json["hasNextPage"],
    hasPreviousPage: json["hasPreviousPage"],
  );
}
