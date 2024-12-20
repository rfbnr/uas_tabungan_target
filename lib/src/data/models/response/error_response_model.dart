import 'dart:convert';

class ErrorResponseModel {
  final String? status;
  final String? message;

  ErrorResponseModel({
    this.status,
    this.message,
  });

  factory ErrorResponseModel.fromJson(String str) =>
      ErrorResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorResponseModel.fromMap(Map<String, dynamic> json) =>
      ErrorResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
      };
}
