class BasicSuccessModel {
  final bool success;
  final String message;

  BasicSuccessModel({required this.success, required this.message});

  factory BasicSuccessModel.fromJson(Map<String, dynamic> json) =>
      BasicSuccessModel(success: json['success'], message: json['message']);
}
