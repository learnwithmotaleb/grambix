class LoginModel {
  final bool success;
  final String token;
  final String refreshToken;
  final AppUser user;

  LoginModel({
    required this.success,
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    token: json["token"],
    refreshToken: json["refreshToken"],
    user: AppUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "refreshToken": refreshToken,
  };
}

class AppUser {
  final String id;
  final String role;
  final String email;

  AppUser({required this.id, required this.role, required this.email});

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      AppUser(id: json["id"], role: json["role"], email: json["email"]);
}
