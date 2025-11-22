class PrivacyModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;

  PrivacyModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Data({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}
