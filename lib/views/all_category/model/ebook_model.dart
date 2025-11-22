class AllEbookModel {
  final bool success;
  final List<Ebook> ebooks;
  final Pagination pagination;

  AllEbookModel({
    required this.success,
    required this.ebooks,
    required this.pagination,
  });

  factory AllEbookModel.fromJson(Map<String, dynamic> json) => AllEbookModel(
    success: json["success"],
    ebooks: List<Ebook>.from(json["ebooks"].map((x) => Ebook.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );
}

class Ebook {
  final String id;
  final String bookCover;
  final String bookName;
  final String synopsis;
  final String pdfFile;
  final int totalPages;
  final CreatedBy createdBy;
  final dynamic category;
  final String categoryName;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Ebook({
    required this.id,
    required this.bookCover,
    required this.bookName,
    required this.synopsis,
    required this.pdfFile,
    required this.totalPages,
    required this.createdBy,
    required this.category,
    required this.categoryName,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) => Ebook(
    id: json["_id"],
    bookCover: json["bookCover"],
    bookName: json["bookName"],
    synopsis: json["synopsis"],
    pdfFile: json["pdfFile"],
    totalPages: json["totalPages"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    category: json["category"],
    categoryName: json["categoryName"] ?? '',
    tags: List<String>.from(json["tags"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class CreatedBy {
  final String id;
  final String name;
  final String email;

  CreatedBy({
    required this.id,
    required this.name,
    required this.email,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
  );

}

class Pagination {
  final int total;
  final int page;
  final int pages;

  Pagination({
    required this.total,
    required this.page,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    pages: json["pages"],
  );
}
