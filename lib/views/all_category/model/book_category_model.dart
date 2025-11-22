class BookCategoryModel {
  final bool success;
  final String message;
  final Data data;

  BookCategoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BookCategoryModel.fromJson(Map<String, dynamic> json) =>
      BookCategoryModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

}

class Data {
  final List<BookCategory> bookCategories;
  final Pagination pagination;

  Data({required this.bookCategories, required this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookCategories: List<BookCategory>.from(
      json["bookCategories"].map((x) => BookCategory.fromJson(x)),
    ),
    pagination: Pagination.fromJson(json["pagination"]),
  );
}

class BookCategory {
  final String id;
  final String name;
  final String image;
  final int v;

  BookCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.v,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) => BookCategory(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    v: json["__v"],
  );
}

class Pagination {
  final int total;
  final int page;
  final int pages;

  Pagination({required this.total, required this.page, required this.pages});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    pages: json["pages"],
  );
}
