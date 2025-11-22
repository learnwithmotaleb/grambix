class UserProfileModel {
  final bool success;
  final User user;

  UserProfileModel({required this.success, required this.user});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        success: json["success"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {"success": success};
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    phone: json["phone"] ?? '',
  );
}
