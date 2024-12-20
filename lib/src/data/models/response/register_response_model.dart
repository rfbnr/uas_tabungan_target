import 'dart:convert';

class RegisterResponseModel {
  final String? status;
  final String? message;
  final DataRegister? data;

  RegisterResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory RegisterResponseModel.fromRawJson(String str) =>
      RegisterResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataRegister.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataRegister {
  final String? name;
  final String? email;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  DataRegister({
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory DataRegister.fromRawJson(String str) =>
      DataRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRegister.fromJson(Map<String, dynamic> json) => DataRegister(
        name: json["name"],
        email: json["email"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
