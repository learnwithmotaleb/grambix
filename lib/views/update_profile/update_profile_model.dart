class UpdateProfileModel {
  final bool success;
  final String message;
  final Data data;

  UpdateProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "message": message};
}

class Data {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String profilePicture;
  final dynamic bio;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String phone;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.profilePicture,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.phone,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    role: json["role"],
    profilePicture: json["profilePicture"] ?? '',
    bio: json["bio"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    phone: json["phone"],
  );
}
