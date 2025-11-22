class HomeBannerModel {
  final bool success;
  final String message;
  final Data data;

  HomeBannerModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) =>
      HomeBannerModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<HomeBanner> banners;

  Data({required this.banners});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banners: List<HomeBanner>.from(
      json["banners"].map((x) => HomeBanner.fromJson(x)),
    ),
  );
}

class HomeBanner {
  final String id;
  final String image;

  HomeBanner({required this.id, required this.image});

  factory HomeBanner.fromJson(Map<String, dynamic> json) =>
      HomeBanner(id: json["_id"], image: json["image"]);
}
