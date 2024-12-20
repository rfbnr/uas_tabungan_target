import 'dart:convert';

class LoginResponseModel {
  final String? status;
  final String? message;
  final DataLogin? data;

  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataLogin.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataLogin {
  final UserLogin? user;
  final String? token;

  DataLogin({
    this.user,
    this.token,
  });

  factory DataLogin.fromRawJson(String str) =>
      DataLogin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        user: json["user"] == null ? null : UserLogin.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class UserLogin {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserLogin({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserLogin.fromRawJson(String str) =>
      UserLogin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
